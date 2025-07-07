function _precompile_()
    ccall(:jl_generating_output, Cint, ()) == 1 || return nothing
    Base.precompile(Tuple{typeof(parse),Type{AVRToolsDeviceFile},AtmelToolsDeviceFilePath})   # time: 1.6428347
end

