using Test
using JET
using AtmelToolsDeviceFiles

@testset "Code linting (JET.jl)" begin
    JET.test_package(AtmelToolsDeviceFiles; target_defined_modules = true)
end
@testset "Code optimization (JET.jl)" begin
    @test_opt target_modules = (AtmelToolsDeviceFiles,) parse(AtmelToolsDeviceFiles.AVRToolsDeviceFile, AtmelToolsDeviceFiles.AtmelLibrary.ATtiny1624())
end
