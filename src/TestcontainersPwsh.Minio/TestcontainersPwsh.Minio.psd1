@{
    ModuleVersion = '1.0'
    GUID = '2a0b1c2d-2456-8901-4567-901234567890'
    RootModule = @('.\bin\Debug\net8.0\TestcontainersPwsh.Minio.dll')
    FunctionsToExport = @()
    CmdletsToExport = @(
        'New-MinioContainer'
    )
}
