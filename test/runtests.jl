using AtmelToolsDeviceFiles
using Test
using Aqua
using JET

@testset "AtmelToolsDeviceFiles.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        Aqua.test_all(AtmelToolsDeviceFiles)
    end
    @testset "Code linting (JET.jl)" begin
        JET.test_package(AtmelToolsDeviceFiles; target_defined_modules = true)
    end
    include("artifacts.jl")
end
