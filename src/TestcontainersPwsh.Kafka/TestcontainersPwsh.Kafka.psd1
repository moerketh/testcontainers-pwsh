@{
    ModuleVersion = '1.0'
    GUID = 'f6a7b8c9-d012-3456-f012-456789012345'
    RootModule = @('.\bin\Debug\net8.0\TestcontainersPwsh.Kafka.dll')
    FunctionsToExport = @()
    CmdletsToExport = @(
        'New-KafkaContainer'
    )
}
