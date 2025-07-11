# Atmel Tools Device Files

Atmel Tools Device Files (`.atdf`) are parsed to produce a specific set of typed objects listed here.


```@meta
CurrentModule = AtmelToolsDeviceFiles
```

```@contents
Pages   = ["types.md"]
```

```@docs
AVRToolsDeviceFile
```

## Device variants
```@docs
Variant
```

## Device summary

This section summarizes a device's architecture, family, name, and memory layout.

```@docs
Device
Parameter
AdressSpace
MemorySegment
DeviceModule
Instance
RegisterGroup
Signal
Interrupt
Interface
PropertyGroup
Property
```

## Peripheral modules
This contains the extended description of available peripheral modules.
```@docs
PeripheralModule
PeripheralRegisterGroup
PeripheralRegisterGroupMode
PeripheralRegister
RegisterMode
PeripheralBitField
PeripheralValueGroup
PeripheralValue
```

## Pinouts
This describes the available pinouts for a device.
```@docs
Pinout
Pin
```

## Index
```@index
Pages   = ["types.md"]
```
