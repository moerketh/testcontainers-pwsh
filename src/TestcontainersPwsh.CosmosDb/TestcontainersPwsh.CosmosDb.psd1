@{
    ModuleVersion = '1.0'
    GUID = '089a0b1a-0234-6789-2345-789012345678'
    RootModule = @('.\bin\Debug\net8.0\TestcontainersPwsh.CosmosDb.dll')
    FunctionsToExport = @()
    CmdletsToExport = @(
        'New-CosmosDbContainer'
    )
}
