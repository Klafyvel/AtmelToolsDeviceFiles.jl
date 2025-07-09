using Test
using AtmelToolsDeviceFiles

@testset "Parse all known ATDF" begin
    atdfs = filter(c -> c ≠ :AtmelLibrary, names(AtmelToolsDeviceFiles.AtmelLibrary))
    @testset "Parse $c" for c in atdfs
        dev = parse(AtmelToolsDeviceFiles.AVRToolsDeviceFile, getproperty(AtmelToolsDeviceFiles.AtmelLibrary, c)())
        @test dev isa AtmelToolsDeviceFiles.AVRToolsDeviceFile
    end
end
