using AtmelToolsDeviceFiles
using Documenter

DocMeta.setdocmeta!(AtmelToolsDeviceFiles, :DocTestSetup, :(using AtmelToolsDeviceFiles); recursive = true)

makedocs(;
    modules = [AtmelToolsDeviceFiles],
    authors = "Hugo Levy-Falk <hugo@klafyvel.me> and contributors",
    sitename = "AtmelToolsDeviceFiles.jl",
    format = Documenter.HTML(;
        canonical = "https://klafyvel.github.io/AtmelToolsDeviceFiles.jl",
        edit_link = "main",
        assets = String[],
        size_threshold_ignore = [
            "atmel-series.md",
        ]
    ),
    pages = [
        "Home" => "index.md",
        "Device definitions" => "types.md",
        "Available devices" => "atmel-series.md",
        "Internals" => "internals.md",
    ],
)

deploydocs(;
    repo = "github.com/Klafyvel/AtmelToolsDeviceFiles.jl",
    devbranch = "main",
)
