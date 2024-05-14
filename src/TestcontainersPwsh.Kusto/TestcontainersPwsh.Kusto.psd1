@{
    ModuleVersion = '1.0'
    GUID = '8e806d26-a4d2-4614-9652-8c52e818cb35'
    PowerShellVersion = '6.0'
    RootModule = @('.\bin\Debug\net8.0\TestcontainersPwsh.Kusto.dll')
    FunctionsToExport = @()
    CmdletsToExport = @(
        'New-KustoContainer'
    )
}
