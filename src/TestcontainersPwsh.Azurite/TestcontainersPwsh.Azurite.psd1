@{
    ModuleVersion = '1.0'
    GUID = 'f7a789a0-f123-5678-1234-678901234567'
    RootModule = @('.\bin\Debug\net8.0\TestcontainersPwsh.Azurite.dll')
    FunctionsToExport = @()
    CmdletsToExport = @(
        'New-AzuriteContainer'
    )
}
