@{
    ModuleVersion = '1.0'
    GUID = 'e5f6a7b8-c901-2345-ef01-345678901234'
    RootModule = @('.\bin\Debug\net8.0\TestcontainersPwsh.RabbitMq.dll')
    FunctionsToExport = @()
    CmdletsToExport = @(
        'New-RabbitMqContainer'
    )
}
