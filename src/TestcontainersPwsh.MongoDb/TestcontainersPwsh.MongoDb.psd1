@{
    ModuleVersion = '1.0'
    GUID = 'c3d4e5f6-a789-0123-cdef-123456789012'
    RootModule = @('.\bin\Debug\net8.0\TestcontainersPwsh.MongoDb.dll')
    FunctionsToExport = @()
    CmdletsToExport = @(
        'New-MongoDbContainer'
    )
}
