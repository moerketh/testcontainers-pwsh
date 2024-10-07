using namespace TestcontainersPwsh.K3s
. $PSScriptRoot\TestBase.ps1

Describe "K3sContainer Cmdlet Tests" {
    BeforeAll {
        try {
            Import-Module -Name "$PSScriptRoot\..\src\TestcontainersPwsh.K3s\TestcontainersPwsh.K3s.psd1" -Force
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
        $global:container = New-K3sContainer

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

    It "Creates a new K3sContainer" {
        $global:container | Should -Not -BeNullOrEmpty
    }

    It "Starts a new K3sContainer" {
        $global:container | Start-Container
        Wait-Event Container.Started        
    }

    It "Gets the Kubeconfig" {
        $global:container.GetKubeconfig() | Should -Not -BeNullOrEmpty
    }

    It "Stops the K3sContainer" {
        $global:container | Stop-Container
        Wait-Event Container.Stopped
        $global:container.IsRunning | Should -BeFalse
    }

    It "Removes the K3sContainer" {
        $global:container | Remove-Container
    }

    AfterAll {
        Unregister-Event "Container.Started" -ErrorAction SilentlyContinue
        Unregister-Event "Container.Stopped" -ErrorAction SilentlyContinue
    }
}