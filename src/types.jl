"""
Describes a specific package for a device.

$(TYPEDFIELDS)
"""
struct Variant
    ordercode::String
    package::String
    pinout::String
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
struct MemorySegment
    exec::String
    name::String
    rw::String
    size::UInt
    start::UInt
    type::String
end

"""
Describes an adress space

$(TYPEDFIELDS)
"""
struct AdressSpace
    endianness::String
    id::String
    name::String
    size::UInt
    start::UInt
    "See also [`MemorySegment`](@ref)."
    memorysegment::Vector{MemorySegment}
end

"""
Describes a device

$(TYPEDFIELDS)
"""
struct Device
    architecture::String
    family::String
    name::String
    "See also [`AdressSpace`](@ref)."
    addressspaces::Vector{AdressSpace}
end

"""
Describes the register group used by a peripheral instance.

$(TYPEDFIELDS)
"""
struct RegisterGroup
    addressspace::String
    name::String
    nameinmodule::String
    offset::UInt
end

"""
Describes a signal for a peripheral module.

$(TYPEDFIELDS)
"""
struct Signal
    func::String
    group::String
    index::UInt
    pad::String
    field::Union{String, Nothing}
end

"""
Describes an instance of a peripheral module.

$(TYPEDFIELDS)
"""
struct Instance
    name::String
    "See also [`RegisterGroup`](@ref)."
    registergroup::RegisterGroup
    "See also [`Signal`](@ref)."
    signals::Vector{Signal}
end

"""
Describes a peripheral module.

$(TYPEDFIELDS)
"""
struct DeviceModule
    id::String
    name::String
    "See also [`Instance`](@ref)."
    instance::Instance
end

"""
Describes an interrupt.

$(TYPEDFIELDS)
"""
struct Interrupt
    index::Int
    moduleinstance::String
    name::String
end

"""
Describes an interface to a device.

$(TYPEDFIELDS)
"""
struct Interface
    name::String
    type::String
end

"""
Describes a property.

$(TYPEDFIELDS)
"""
struct Property
    name::String
    value::String
end

"""
Describes a property group for a device.

$(TYPEDFIELDS)
"""
struct PropertyGroup
    name::String
    properties::Vector{Property}
end

"""
Describes a bit field in a register associated to a peripheral.

$(TYPEDFIELDS)
"""
struct PeripheralBitField
    caption::String
    mask::UInt
    name::String
    rw::String
end

"""
Describes a register related to a peripheral.

$(TYPEDFIELDS)
"""
struct PeripheralRegister
    caption::String
    interval::UInt
    name::String
    offset::UInt
    rw::String
    size::Int
    "See also [`PeripheralBitField`](@ref)."
    bitfields::Vector{PeripheralBitField}
end

"""
Describes a group of registers related to a peripheral.

$(TYPEDFIELDS)
"""
struct PeripheralRegisterGroup
    caption::String
    name::String
    size::UInt
    registers::Vector{PeripheralRegister}
end

"""
Describes a specific value for a peripheral module.

$(TYPEDFIELDS)
"""
struct PeripheralValue
    caption::String
    name::String
    value::String
end

"""
Describes a set of values for a peripheral module.

$(TYPEDFIELDS)
"""
struct PeripheralValueGroup
    caption::String
    name::String
    "See also [`PeripheralValue`](@ref)"
    values::Vector{PeripheralValue}
end

"""
Describes the layout and usage of a peripheral module.

$(TYPEDFIELDS)

The modules listed here correspond to the short version listed as [`DeviceModule`](@ref) in the device definition.
"""
struct PeripheralModule
    caption::String
    id::String
    name::String
    "See also [`PeripheralRegisterGroup`](@ref)."
    registergroup::PeripheralRegisterGroup
    "See also [`PeripheralValueGroup`](@ref)."
    valuegroup::Vector{PeripheralValueGroup}
end

"""
Describes a pin for a device's pinout.

$(TYPEDFIELDS)
"""
struct Pin
    pad::String
    position::Int
end

"""
Describe a specific available pinout for a device.

$(TYPEDFIELDS)
"""
struct Pinout
    name::String
    "See also [`Pin`](@ref)."
    pins::Vector{Pin}
end

"""
A fully parsed Atmel Tools Device File.

$(TYPEDFIELDS)
"""
struct AVRToolsDeviceFile
    "See also [`Variant`](@ref)."
    variants::Vector{Variant}
    "See also [`Device`](@ref)."
    devices::Vector{Device}
    "See also [`DeviceModule`](@ref)."
    peripherals::Vector{DeviceModule}
    "See also [`Interrupt`](@ref)."
    interrupts::Vector{Interrupt}
    "See also [`Interface`](@ref)."
    interfaces::Vector{Interface}
    "See also [`PropertyGroup`](@ref)."
    propertygroups::Vector{PropertyGroup}
    "See also [`PeripheralModule`](@ref)."
    peripheralmodules::Vector{PeripheralModule}
    "See also [`Pinout`](@ref)."
    pinouts::Vector{Pinout}
end
