. $PSScriptRoot\TestBase.ps1

Describe "KustoContainer Cmdlets Tests" {
    BeforeAll {
        try {
            Import-Module -Name "$PSScriptRoot\..\src\TestcontainersPwsh.Kusto\TestcontainersPwsh.Kusto.psd1" -Force
        } catch {
            if ($_.Exception -is [System.Reflection.ReflectionTypeLoadException]) {
                $exception = $_.Exception
                Write-Host "ReflectionTypeLoadException: $($exception.Message)"
                Write-Host "LoaderExceptions:"
                foreach ($loaderException in $exception.LoaderExceptions) {
                    Write-Host "    $loaderException"
                }
            }
            throw $_
        }

        # Create the container once for all tests
        $global:container = New-KustoContainer

        #Register container started event
        $objectEventArgs = @{
            InputObject = $global:container
            EventName = 'Started'
            SourceIdentifier = 'Container.Started'
        }
        Register-ObjectEvent @objectEventArgs

        #Register container stopped event
        $objectEventArgs = @{
            InputObject = $global:container
            EventName = 'Stopped'
            SourceIdentifier = 'Container.Stopped'
        } 
        Register-ObjectEvent @objectEventArgs
    }

    It "Creates a new KustoContainer" {

        $global:container | Should -Not -BeNullOrEmpty
    }

    It "Starts the KustoContainer" {
        
        $global:container | Start-Container
        Wait-Event Container.Started
        
        $localStartedTime = $container.StartedTime.ToLocalTime()
        $now = Get-Date
        $localStartedTime | Should -BeGreaterThan ($now.AddMinutes(-1))
        $localStartedTime | Should -BeLessThan $now
    }

    It "Connects to the KustoContainer" {
        
        $response = Invoke-WebRequest -Uri $global:container.GetConnectionString() -Method Get
        $response.StatusCode | Should -Be 200
    }

    It "Stops the KustoContainer" {
        
        $global:container | Stop-Container
        Wait-Event Container.Stopped
    }

    It "Removes the KustoContainer" {
        
        $global:container | Remove-Container
    }

    AfterAll {
        Unregister-Event "Container.Started" -ErrorAction SilentlyContinue
        Unregister-Event "Container.Stopped" -ErrorAction SilentlyContinue
    }
}
