# testcontainers-pwsh

A PowerShell module that wraps some features of `testcontainers-dotnet`, allowing to use these features as PowerShell commandlets.

## Using testcontainers-dotnet from powershell
```
Add-Type -Path "$PSScriptRoot\src\TestcontainersPwsh.Kusto\bin\Debug\net8.0\Testcontainers.Kusto.dll"
$container = (New-Object -TypeName Testcontainers.Kusto.KustoBuilder).Build()
$container.StartAsync().GetAwaiter().GetResult();
Invoke-WebRequest -Uri $container.GetConnectionString() -Method Get
$container.StopAsync().GetAwaiter().GetResult();
$container.DisposeAsync().AsTask().Wait();
```

## Using this module
```
Import-Module "$PSScriptRoot\src\TestcontainersPwsh.Kusto\TestcontainersPwsh.Kusto.psd1"
$container = New-KustoContainer 
$container | Start-Container
Invoke-WebRequest -Uri $container.GetConnectionString() -Method Get
$container | Stop-Container 
$container | Remove-Container
```

This project uses the [testcontainers-dotnet](https://github.com/testcontainers/testcontainers-dotnet) library, which is licensed under the MIT License.
