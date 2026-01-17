. $PSScriptRoot\TestBase.ps1

Describe "RabbitMqContainer Cmdlets Tests" {
    BeforeAll {
        try {
            Import-Module -Name "$PSScriptRoot\..\src\TestcontainersPwsh.RabbitMq\TestcontainersPwsh.RabbitMq.psd1" -Force
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

        $global:container = New-RabbitMqContainer

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

    It "Creates a new RabbitMqContainer" {
        $global:container | Should -Not -BeNullOrEmpty
    }

    It "Starts RabbitMqContainer" {
        $global:container | Start-Container
        Wait-Event Container.Started
        $localStartedTime = $container.StartedTime.ToLocalTime()
        $now = Get-Date
        $localStartedTime | Should -BeGreaterThan ($now.AddMinutes(-1))
        $localStartedTime | Should -BeLessThan $now
    }

    It "Gets connectionstring" {
        $global:container.GetConnectionString() | Should -Not -BeNullOrEmpty
    }

    It "Stops RabbitMqContainer" {
        $global:container | Stop-Container
        Wait-Event Container.Stopped
        $global:container.IsRunning | Should -BeFalse
    }

    It "Removes RabbitMqContainer" {
        $global:container | Remove-Container
    }

    AfterAll {
        Unregister-Event "Container.Started" -ErrorAction SilentlyContinue
        Unregister-Event "Container.Stopped" -ErrorAction SilentlyContinue
    }
}
