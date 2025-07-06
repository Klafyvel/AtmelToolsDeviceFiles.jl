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
AdressSpace
MemorySegment
```

## Peripheral modules summary
This section describes the peripheral modules available on a device.

```@docs
DeviceModule
Instance
RegisterGroup
Signal
```

## Interrupts

```@docs
Interrupt
```

## Intefaces
```@docs
Interface
```

## Property groups
```@docs
PropertyGroup
Property
```

## Peripheral modules
This contains the extended description of available peripheral modules.
```@docs
PeripheralModule
PeripheralRegisterGroup
PeripheralRegister
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
