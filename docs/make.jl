using AtmelToolsDeviceFiles
using Documenter

DocMeta.setdocmeta!(AtmelToolsDeviceFiles, :DocTestSetup, :(using AtmelToolsDeviceFiles); recursive=true)

makedocs(;
    modules=[AtmelToolsDeviceFiles],
    authors="Hugo Levy-Falk <hugo@klafyvel.me> and contributors",
    sitename="AtmelToolsDeviceFiles.jl",
    format=Documenter.HTML(;
        canonical="https://klafyvel.github.io/AtmelToolsDeviceFiles.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/klafyvel/AtmelToolsDeviceFiles.jl",
    devbranch="main",
)
