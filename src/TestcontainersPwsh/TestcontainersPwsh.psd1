@{
    ModuleVersion = '1.0'
    GUID = 'b985e06c-9729-404d-9565-22e502db7371'
    PowerShellVersion = '6.0'
    RootModule = @('.\bin\Debug\net8.0\TestcontainersPwsh.dll')
    FunctionsToExport = @()
    CmdletsToExport = @(
        'New-ContainerBuilder',
        'Get-ContainerWaitStrategy',
        'Set-ContainerHostname',
        'Set-ContainerImage',
        'Set-ContainerName',
        'Set-ContainerPortBinding',
        'Set-ContainerEnvironment',
        'Set-ContainerResourceMapping',
        'Set-ContainerAutoRemove',
        'Set-ContainerWaitStrategy',
        'Start-ContainerBuild',
        'Start-Container',
        'Stop-Container',
        'Remove-Container'
        )
}
