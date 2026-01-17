@{
    ModuleVersion = '1.0'
    GUID = '19a0b1c2-1345-7890-3456-890123456789'
    RootModule = @('.\bin\Debug\net8.0\TestcontainersPwsh.Keycloak.dll')
    FunctionsToExport = @()
    CmdletsToExport = @(
        'New-KeycloakContainer'
    )
}
