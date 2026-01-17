@{
    ModuleVersion = '1.0'
    GUID = 'b2c3d4e5-f6a7-8901-bcde-f12345678901'
    RootModule = @('.\bin\Debug\net8.0\TestcontainersPwsh.Redis.dll')
    FunctionsToExport = @()
    CmdletsToExport = @(
        'New-RedisContainer'
    )
}
