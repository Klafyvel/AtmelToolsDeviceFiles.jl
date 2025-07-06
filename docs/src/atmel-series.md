# Predefined device definitions

`AtmelToolsDeviceFiles` comes with some pre-defined devices files. They are stored as [`lazy Artifacts`](https://docs.julialang.org/en/v1/stdlib/LazyArtifacts/) downloaded from [`https://packs.download.microchip.com`](https://packs.download.microchip.com) that can be summoned at will. 

For convenience, they are accessible through the [`AtmelToolsDeviceFiles.AtmelLibrary`](@ref) sub-module.

!!! note "Adding new devices."
    More device files are available in Microship's download page and can be added uppon request. Open an issue if you require one!

## Accessible device files

```@index
Modules = [AtmelToolsDeviceFiles.AtmelLibrary]
```

```@autodocs
Modules = [AtmelToolsDeviceFiles.AtmelLibrary]
Private = false
```


## Internals

```@docs
AtmelToolsDeviceFiles.AtmelToolsDeviceFilePath
AtmelToolsDeviceFiles.devicefilepath
```
