"""
Abstract supertype for parsing ATDF.
"""
abstract type AbstractATDF end

"""
Describes a specific package for a device.

$(TYPEDFIELDS)
"""
struct Variant <: AbstractATDF
    ordercode::String
    package::String
    pinout::Union{String, Nothing}
    speedmax::Int
    tempmax::Float64
    tempmin::Float64
    vccmax::Float64
    vccmin::Float64
end

"""
Describes a memory segment.

$(TYPEDFIELDS)
"""
struct MemorySegment <: AbstractATDF
    exec::Union{String, Nothing}
    name::String
    rw::Union{String, Nothing}
    size::UInt
    start::UInt
    type::String
end

"""
Describes an adress space

$(TYPEDFIELDS)
"""
struct AdressSpace <: AbstractATDF
    endianness::String
    id::String
    name::String
    size::UInt
    start::UInt
    "See also [`MemorySegment`](@ref)."
    memory_segments::Vector{MemorySegment}
end

"""
Describes the register group used by a peripheral instance.

$(TYPEDFIELDS)
"""
struct RegisterGroup <: AbstractATDF
    address_space::String
    name::String
    name_in_module::String
    offset::UInt
end

"""
Describes a signal for a peripheral module.

$(TYPEDFIELDS)
"""
struct Signal <: AbstractATDF
    function_::Union{String, Nothing}
    group::String
    index::Union{UInt, Nothing}
    pad::String
    field::Union{String, Nothing}
end

"""
Describes a parameter.

$(TYPEDFIELDS)
"""
struct Parameter <: AbstractATDF
    name::String
    value::String
end

"""
Describes an instance of a peripheral module.

$(TYPEDFIELDS)
"""
struct Instance <: AbstractATDF
    name::String
    "See also [`RegisterGroup`](@ref)."
    register_group::Union{RegisterGroup, Nothing}
    "See also [`Signal`](@ref)."
    signals::Vector{Signal}
    "See also [`Parameter`](@ref)."
    parameters::Vector{Parameter}
end

"""
Describes a peripheral module.

$(TYPEDFIELDS)
"""
struct DeviceModule <: AbstractATDF
    id::Union{String, Nothing}
    name::String
    "See also [`Instance`](@ref)."
    instances::Vector{Instance}
end

"""
Describes an interrupt.

$(TYPEDFIELDS)
"""
struct Interrupt <: AbstractATDF
    index::Int
    module_instance::Union{String, Nothing}
    name::String
end

"""
Describes an interface to a device.

$(TYPEDFIELDS)
"""
struct Interface <: AbstractATDF
    name::String
    type::String
end

"""
Describes a property.

$(TYPEDFIELDS)
"""
struct Property <: AbstractATDF
    name::String
    value::String
end

"""
Describes a property group for a device.

$(TYPEDFIELDS)
"""
struct PropertyGroup <: AbstractATDF
    name::String
    properties::Vector{Property}
end

"""
Describes a device

$(TYPEDFIELDS)
"""
struct Device <: AbstractATDF
    architecture::String
    family::String
    name::String
    "See also [`AdressSpace`](@ref)."
    address_spaces::Vector{AdressSpace}
    "See also [`DeviceModule`](@ref)."
    peripherals::Vector{DeviceModule}
    "See also [`Interrupt`](@ref)."
    interrupts::Vector{Interrupt}
    "See also [`Interface`](@ref)."
    interfaces::Vector{Interface}
    "See also [`PropertyGroup`](@ref)."
    property_groups::Vector{PropertyGroup}
    "See also [`Parameter`](@ref)."
    parameters::Vector{Parameter}
end

"""
Describes a bit field in a register associated to a peripheral.

$(TYPEDFIELDS)
"""
struct PeripheralBitField <: AbstractATDF
    caption::Union{String, Nothing}
    mask::UInt
    name::String
    rw::Union{String, Nothing}
    values::Union{Nothing, String}
end

"""
Register modes.

$(TYPEDFIELDS)
"""
struct RegisterMode <: AbstractATDF
    name::String
    qualifier::String
    value::String
end

"""
Describes a register related to a peripheral.

$(TYPEDFIELDS)
"""
struct PeripheralRegister <: AbstractATDF
    caption::Union{String, Nothing}
    initval::Union{Nothing, UInt}
    name::String
    offset::UInt
    rw::Union{String, Nothing}
    size::Int
    "See also [`PeripheralBitField`](@ref)."
    bitfields::Vector{PeripheralBitField}
    "See also [`RegisterMode`](@ref)."
    modes::Vector{RegisterMode}
end

"""
Mode of a register group

$(TYPEDFIELDS)
"""
struct PeripheralRegisterGroupMode <: AbstractATDF
    caption::String
    name::String
    qualifier::String
    value::String
end

"""
Describes a group of registers related to a peripheral.

$(TYPEDFIELDS)
"""
struct PeripheralRegisterGroup <: AbstractATDF
    caption::Union{String, Nothing}
    name::String
    size::Union{UInt, Nothing}
    "See also [`PeripheralRegister`](@ref)."
    registers::Vector{PeripheralRegister}
    "See also [`PeripheralRegisterGroupMode`](@ref)."
    modes::Vector{PeripheralRegisterGroupMode}
end

"""
Describes a specific value for a peripheral module.

$(TYPEDFIELDS)
"""
struct PeripheralValue <: AbstractATDF
    caption::String
    name::String
    value::String
end

"""
Describes a set of values for a peripheral module.

$(TYPEDFIELDS)
"""
struct PeripheralValueGroup <: AbstractATDF
    caption::Union{String, Nothing}
    name::String
    "See also [`PeripheralValue`](@ref)"
    values::Vector{PeripheralValue}
end

"""
Describes the layout and usage of a peripheral module.

$(TYPEDFIELDS)

The modules listed here correspond to the short version listed as [`DeviceModule`](@ref) in the device definition.
"""
struct PeripheralModule <: AbstractATDF
    caption::Union{String, Nothing}
    id::Union{String, Nothing}
    name::String
    "See also [`PeripheralRegisterGroup`](@ref)."
    register_group::Vector{PeripheralRegisterGroup}
    "See also [`PeripheralValueGroup`](@ref)."
    value_groups::Vector{PeripheralValueGroup}
end

"""
Describes a pin for a device's pinout.

$(TYPEDFIELDS)
"""
struct Pin <: AbstractATDF
    pad::String
    position::String
end

"""
Describe a specific available pinout for a device.

$(TYPEDFIELDS)
"""
struct Pinout <: AbstractATDF
    name::String
    "See also [`Pin`](@ref)."
    pins::Vector{Pin}
end

"""
A fully parsed Atmel Tools Device File.

$(TYPEDFIELDS)
"""
struct AVRToolsDeviceFile <: AbstractATDF
    "See also [`Variant`](@ref)."
    variants::Vector{Variant}
    "See also [`Device`](@ref)."
    devices::Vector{Device}
    "See also [`PeripheralModule`](@ref)."
    modules::Vector{PeripheralModule}
    "See also [`Pinout`](@ref)."
    pinouts::Vector{Pinout}
end

Base.show(io::IO, x::AVRToolsDeviceFile) = print(io, "AVRToolsDeviceFile()")
