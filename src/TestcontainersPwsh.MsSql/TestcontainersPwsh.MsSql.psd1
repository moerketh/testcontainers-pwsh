@{
    ModuleVersion = '1.0'
    GUID = 'ce204be0-1383-4cd8-9d5f-6dff2c4d0185'
    PowerShellVersion = '6.0'
    RootModule = @('.\bin\Debug\net8.0\TestcontainersPwsh.MsSql.dll')
    FunctionsToExport = @()
    CmdletsToExport = @(
        'New-MsSqlContainer',
        'Write-MsSqlScript'
    )
}
