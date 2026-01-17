@{
    ModuleVersion = '1.0'
    GUID = 'a1b2c3d4-e5f6-7890-abcd-ef1234567890'
    RootModule = @('.\bin\Debug\net8.0\TestcontainersPwsh.PostgreSql.dll')
    FunctionsToExport = @()
    CmdletsToExport = @(
        'New-PostgreSqlContainer'
    )
}
