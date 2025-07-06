using Test
using AtmelToolsDeviceFiles

@testset "Check that artifacts are available." begin
    @testset "Check that $file is available" for file in Base.names(AtmelToolsDeviceFiles.AtmelLibrary)
        fp = getproperty(AtmelToolsDeviceFiles.AtmelLibrary, file)
        if fp isa Function
            @test AtmelToolsDeviceFiles.devicefilepath(fp()) isa String
            @test isfile(AtmelToolsDeviceFiles.devicefilepath(fp()))
        end
    end
end
