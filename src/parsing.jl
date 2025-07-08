function Base.parse(::Type{AVRToolsDeviceFile}, x)
    doc = read(devicefilepath(x), XML.Node)
    return node_to_atdf(doc)
end

"""
    node_to_atdf([dest::Type{T},] node::XML.Node) where {T <: AbstractATDF}

Convert an XML node to the destination type. If `dest` is not given, then `node`
`XML.nodetype` must me an `XML.Document`, and the function will attempt to extract
the root `<avr-tools-device-file>` node and convert it to an [`AVRToolsDeviceFile`](@ref)
instance.
"""
function node_to_atdf(x::XML.Node)
    t = XML.nodetype(x)
    if t == XML.Document
        children = something(XML.children(x), XML.Node[])
        i = findfirst(children) do child
            XML.nodetype(child) == XML.Element && XML.tag(child) == "avr-tools-device-file"
        end
        if isnothing(i)
            error("Malformed file, cannot find `avr-tools-device-file` tag at the root.")
        end
        return node_to_atdf(AVRToolsDeviceFile, children[i])
    else
        return nothing
    end
end

"""
    _has_wrapper_children(T)
Default to `false`. Types that have wrapped children must return true.

Example of a wrapped children case:
```xml
<tag>
<signals>
<signal></signal>
...
<signal></signal>
</signals>
</tag>
```

The equivalent un-wrapped case would be:
```xml
<tag>
<signal></signal>
...
<signal></signal>
</tag>
```
"""
_has_wrapper_children(::Type{T}) where {T} = false
_has_wrapper_children(::Type{AVRToolsDeviceFile}) = true
_has_wrapper_children(::Type{Device}) = true
_has_wrapper_children(::Type{Instance}) = true

"""
$(SIGNATURES)

Sometimes the name of the wrapper does not match the name of the children. Defining
a method for this function allows overwriting the default child name.
"""
_special_wrapped_children_name(::Type{DeviceModule}, predicted) = if predicted == "peripheral"
    return "module"
else
    return predicted
end
_special_wrapped_children_name(::Type{InstanceParam}, predicted) = if predicted == "parameter"
    return "param"
else
    return predicted
end

"""
    _build_xml_attribute_name(fieldname)

Transform a field name into an XML attribute name.
"""
function _build_xml_attribute_name(fieldname)
    xmlname = rstrip(String(fieldname), '_')
    xmlname = replace(xmlname, "_" => "-")
    return xmlname
end

"""
    _generate_attribute_fetching(name, type)

Generate the code to fetch an attribute given a field `name` and a template `type`.
Returns a named tuple with a `fetchcode` expression to retrieve the attribute, and
a `checkcode` expression to perform verification on the input XML node.
"""
function _generate_attribute_fetching(name, ::Type{T}) where {T}
    attributename = _build_xml_attribute_name(name)
    fetchcode = if T == String
        :(attributes[$attributename])
    elseif hasmethod(convert, (Type{T}, String))
        :(convert($T, attributes[$attributename]))
    elseif hasmethod(parse, (Type{T}, String))
        :(parse($T, attributes[$attributename]))
    else
        error("Unable to write attribute fetching expression for $name::$T.")
    end
    checkcode = quote
        if !haskey(attributes, $attributename)
            error("Malformed file. Attribute $($attributename) is expected in node $node")
        end
    end
    return (; fetchcode, checkcode)
end
function _generate_attribute_fetching(name, ::Type{Union{T, Nothing}}) where {T}
    attributename = _build_xml_attribute_name(name)
    fetchcode = if T == String
        :(get(attributes, $attributename, nothing))
    elseif hasmethod(convert, (Type{T}, String))
        :(
            if haskey(attributes, $attributename)
                convert($T, attributes[$attributename])
            else
                nothing
            end
        )
    elseif hasmethod(parse, (Type{T}, String))
        :(
            if haskey(attributes, $attributename)
                parse($T, attributes[$attributename])
            else
                nothing
            end
        )
    else
        error("Unable to write attribute fetching expression for $name::$T.")
    end
    checkcode = :()
    return (; fetchcode, checkcode)
end

"""
    _generate_single_child_fetching(name, type)

Generate the codes to fetch a single struct child `name` of an XML node using 
template `type`.
"""
function _generate_single_child_fetching(name, ::Type{T}) where {T <: AbstractATDF}
    attributename = _build_xml_attribute_name(name)
    return (
        condition = :(t == $attributename), type = T, variable = name, attributename = attributename, fetchcode = quote
            if isnothing($name)
                $name = node_to_atdf($T, child)
            else
                error("Expected only one $($attributename) as direct child of $node.")
            end
        end,
    )
end

"""
    _generate_children_name(fieldname)

Generate the expected tag name of children corresponding to a `fieldname`.
"""
function _generate_children_name(fieldname)
    xmlname = replace(String(fieldname), r"ies$" => "y")
    xmlname = rstrip(xmlname, 's')
    xmlname = replace(xmlname, "_" => "-")
    return xmlname
end
"""
    _generate_children_fetching(name, Vector{type})

Generate the codes to fetch struct children of an XML node. Return a named tuple
with the `condition` to trigger the code fetching, the `type` of the children, 
the `variable` used in the main function to store the children, and the `fetchcode`
to parse a specific child.
"""
function _generate_children_fetching(name, ::Type{Vector{T}}) where {T <: AbstractATDF}
    tagname = _generate_children_name(name)
    return (
        condition = :(t == $tagname), type = T, variable = name, fetchcode = quote
            push!($name, node_to_atdf($T, child))
        end,
    )
end
"""
    _generate_wrapper_children_name(fieldname)
Generate the expected wrapper tag name of children corresponding to a `fieldname`.
"""
function _generate_wrapper_children_name(fieldname)
    xmlname = replace(String(fieldname), "_" => "-")
    return xmlname
end
"""
    _fetch_wrapped_children(childtype, node, name)

Iterate over a child `node` to extract the grand-children of type `childtype` with
the given XML `tag`. Return a vector of `childtype`. Used by the code generated in
[`_generate_wrapped_children_fetching`](@ref).
"""
function _fetch_wrapped_children(::Type{T}, node, name) where {T <: AbstractATDF}
    result = T[]
    for child in something(XML.children(node), XML.Node[])
        t = XML.tag(child)
        if t ≠ name
            error("Malformed file, unexpected tag $t: $child direct child of $node")
        else
            push!(result, node_to_atdf(T, child))
        end
    end
    return result
end
"""
    _generate_wrapped_children_fetching(name, Vector{type})

Generate the codes to fetch wrapped struct children of an XML node. Return a named tuple
with the `condition` to trigger the code fetching, the `type` of the children, 
the `variable` used in the main function to store the children, and the `fetchcode`
to parse a specific child using [`_fetch_wrapped_children`](@ref).
"""
function _generate_wrapped_children_fetching(name, ::Type{Vector{T}}) where {T <: AbstractATDF}
    wrappertagname = _generate_wrapper_children_name(name)
    tagname = _generate_children_name(name)
    if hasmethod(_special_wrapped_children_name, (Type{T}, String))
        tagname = _special_wrapped_children_name(T, tagname)
    end
    return (
        condition = :(t == $wrappertagname), type = T, variable = name, fetchcode = quote
            append!($name, _fetch_wrapped_children($T, child, $tagname))
        end,
    )
end

@generated function node_to_atdf(dest::Type{T}, node::XML.Node) where {T <: AbstractATDF}
    #=
    The generated function comprises three sections. First variable initialization,
    where we fetch the attributes and initialize the children. Then a for loop
    that iterates over the children and populates the single children and vector
    children, parsing them as defined in their struct definition. Finally a return
    block where we build the final object.
    =#
    # First we explore the fields of the struct `dest` and determine what is
    # an attribute, what is a single struct child, and what is an array of children.
    attributesfetching = []
    singlechildfetching = []
    multiplechildrenfetching = []
    objectbuilding = []
    for (t, n) in zip(fieldtypes(T), fieldnames(T))
        if t <: AbstractATDF
            push!(singlechildfetching, _generate_single_child_fetching(n, t))
            push!(objectbuilding, n)
        elseif t <: AbstractVector && _has_wrapper_children(T)
            push!(multiplechildrenfetching, _generate_wrapped_children_fetching(n, t))
            push!(objectbuilding, n)
        elseif t <: AbstractVector && !_has_wrapper_children(T)
            push!(multiplechildrenfetching, _generate_children_fetching(n, t))
            push!(objectbuilding, n)
        else
            attribute = _generate_attribute_fetching(n, t)
            push!(attributesfetching, attribute)
            push!(objectbuilding, attribute.fetchcode)
        end
    end
    # Then, we build the initialization section of the generated function.
    finalcode = []
    if !isempty(attributesfetching)
        push!(finalcode, :(attributes = something(XML.attributes(node), OrderedDict{String, String}())))
        for attribute in attributesfetching
            push!(finalcode, attribute.checkcode)
        end
    end
    for child in singlechildfetching
        varname = child.variable
        push!(finalcode, :($varname = nothing))
    end
    for child in multiplechildrenfetching
        varname = child.variable
        t = child.type
        push!(finalcode, :($varname = $t[]))
    end
    # Then, if required, we build the for loop that iterates over the children.
    if !isempty(singlechildfetching) || !isempty(multiplechildrenfetching)
        errorblock = :(error("Malformed file, unexpected tag $t: $child direct child of $node."))
        ifelseblock = foldr([singlechildfetching..., multiplechildrenfetching...], init = errorblock) do child, r
            Expr(:elseif, child.condition, child.fetchcode, r)
        end
        ifelseblock.head = :if
        child_fetching_expr = Expr(:for, :(child = XML.children(node)), Expr(:block, :(t = XML.tag(child)), ifelseblock))
        push!(finalcode, child_fetching_expr)
    end
    for child in singlechildfetching
        varname = child.variable
        attributename = child.attributename
        push!(
            finalcode, :(
                if isnothing($varname)
                    error("Malformed file. Node $node expected a child $($attributename).")
                end
            )
        )
    end
    # Finaly, we generate the code that builds the returned object.
    push!(finalcode, Expr(:call, T, objectbuilding...))
    finalexpr = Expr(:block, finalcode...)
    return finalexpr
end
