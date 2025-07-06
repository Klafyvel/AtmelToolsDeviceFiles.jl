module AtmelToolsDeviceFiles

using DocStringExtensions
using LazyArtifacts
using XML

include("types.jl")
include("parsing.jl")

"""
A convenience wrapper for the path to a device definition file.
"""
struct AtmelToolsDeviceFilePath
    path::String
end
"""
Returns the path to the devicde definition file.
"""
devicefilepath(dev::AtmelToolsDeviceFilePath) = dev.path
devicefilepath(path::AbstractString) = path

include("atmelseries.jl")

public AtmelLibrary

public AVRToolsDeviceFile, Variant, Device, AdressSpace, MemorySegment
public DeviceModule, Instance, RegisterGroup, Signal, Interrupt, Interface
public PropertyGroup, Property, PeripheralModule, PeripheralRegisterGroup
public PeripheralRegister, PeripheralBitField, PeripheralValueGroup
public PeripheralValue, Pinout, Pin

end
