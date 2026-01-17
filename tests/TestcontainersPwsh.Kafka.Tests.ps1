. $PSScriptRoot\TestBase.ps1

Describe "KafkaContainer Cmdlets Tests" {
    BeforeAll {
        try {
            Import-Module -Name "$PSScriptRoot\..\src\TestcontainersPwsh.Kafka\TestcontainersPwsh.Kafka.psd1" -Force
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

        $global:container = New-KafkaContainer

        $objectEventArgs = @{
            InputObject = $global:container
            EventName = 'Started'
            SourceIdentifier = 'Container.Started'
        }
        Register-ObjectEvent @objectEventArgs

        $objectEventArgs = @{
            InputObject = $global:container
            EventName = 'Stopped'
            SourceIdentifier = 'Container.Stopped'
        }
        Register-ObjectEvent @objectEventArgs
    }

    It "Creates a new KafkaContainer" {
        $global:container | Should -Not -BeNullOrEmpty
    }

    It "Starts KafkaContainer" {
        $global:container | Start-Container
        Wait-Event Container.Started
        $localStartedTime = $container.StartedTime.ToLocalTime()
        $now = Get-Date
        $localStartedTime | Should -BeGreaterThan ($now.AddMinutes(-1))
        $localStartedTime | Should -BeLessThan $now
    }

    It "Gets bootstrap servers" {
        $global:container.GetBootstrapAddress() | Should -Not -BeNullOrEmpty
    }

    It "Stops KafkaContainer" {
        $global:container | Stop-Container
        Wait-Event Container.Stopped
        $global:container.IsRunning | Should -BeFalse
    }

    It "Removes KafkaContainer" {
        $global:container | Remove-Container
    }

    AfterAll {
        Unregister-Event "Container.Started" -ErrorAction SilentlyContinue
        Unregister-Event "Container.Stopped" -ErrorAction SilentlyContinue
    }
}
