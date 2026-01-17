@{
    ModuleVersion = '1.0'
    GUID = '80cf8fbf-d8d6-4f48-bbc8-1ce7b73aba90'
    RootModule = @('.\bin\Debug\net8.0\TestcontainersPwsh.K3s.dll')
    FunctionsToExport = @()
    CmdletsToExport = @(
        'New-K3sContainer'
    )
}
