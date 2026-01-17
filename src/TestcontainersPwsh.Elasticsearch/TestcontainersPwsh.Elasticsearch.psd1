@{
    ModuleVersion = '1.0'
    GUID = 'e6f7a789-e012-4567-0123-567890123456'
    RootModule = @('.\bin\Debug\net8.0\TestcontainersPwsh.Elasticsearch.dll')
    FunctionsToExport = @()
    CmdletsToExport = @(
        'New-ElasticsearchContainer'
    )
}
