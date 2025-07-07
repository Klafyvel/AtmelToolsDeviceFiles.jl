using AtmelToolsDeviceFiles
using Test
using Aqua

@testset "AtmelToolsDeviceFiles.jl" begin
    @testset "Code quality (Aqua.jl)" begin
        # unbound_args is broken for our code generation that relies on dispatching
        # on Type{Union{Nothing, T}}.
        Aqua.test_all(AtmelToolsDeviceFiles, unbound_args = false)
    end
    include("jet.jl")
    include("artifacts.jl")
end
