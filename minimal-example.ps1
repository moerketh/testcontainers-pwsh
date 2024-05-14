Import-Module "$PSScriptRoot\src\TestcontainersPwsh.Kusto\TestcontainersPwsh.Kusto.psd1"
$container = New-KustoContainer 
$container | Start-Container
Invoke-WebRequest -Uri $container.GetConnectionString() -Method Get
$container | Stop-Container 
$container | Remove-Container