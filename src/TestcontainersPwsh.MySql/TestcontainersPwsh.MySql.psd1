@{
    ModuleVersion = '1.0'
    GUID = 'd4e5f6a7-b890-1234-def0-234567890123'
    RootModule = @('.\bin\Debug\net8.0\TestcontainersPwsh.MySql.dll')
    FunctionsToExport = @()
    CmdletsToExport = @(
        'New-MySqlContainer'
    )
}
