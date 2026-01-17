. $PSScriptRoot\TestBase.ps1

Describe "ElasticsearchContainer Cmdlets Tests" {
    BeforeAll {
        try {
            Import-Module -Name "$PSScriptRoot\..\src\TestcontainersPwsh.Elasticsearch\TestcontainersPwsh.Elasticsearch.psd1" -Force
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

        # Create container once for all tests
        $global:container = New-ElasticsearchContainer

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

    It "Creates a new ElasticsearchContainer" {
        $global:container | Should -Not -BeNullOrEmpty
    }

    It "Starts ElasticsearchContainer" {
        $global:container | Start-Container
        Wait-Event Container.Started

        $localStartedTime = $container.StartedTime.ToLocalTime()
        $now = Get-Date
        $localStartedTime | Should -BeGreaterThan ($now.AddMinutes(-1))
        $localStartedTime | Should -BeLessThan $now
    }

    It "Gets connection string" {
        $global:container.GetConnectionString() | Should -Not -BeNullOrEmpty
    }

    It "Stops ElasticsearchContainer" {
        $global:container | Stop-Container
        Wait-Event Container.Stopped
    }

    It "Removes ElasticsearchContainer" {
        $global:container | Remove-Container
    }

    AfterAll {
        Unregister-Event "Container.Started" -ErrorAction SilentlyContinue
        Unregister-Event "Container.Stopped" -ErrorAction SilentlyContinue
    }
}
