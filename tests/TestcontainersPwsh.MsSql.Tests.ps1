. $PSScriptRoot\TestBase.ps1

Describe "MsSqlContainer Cmdlet Tests" {
    BeforeAll {
        try {
            Import-Module -Name "$PSScriptRoot\..\src\TestcontainersPwsh.MsSql\TestcontainersPwsh.MsSql.psd1" -Force
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
        $global:container = New-MsSqlContainer

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

    It "Creates a new MsSqlContainer" {
        $global:container | Should -Not -BeNullOrEmpty
    }

    It "Starts a new MsSqlContainer" {
        $global:container | Start-Container
        Wait-Event Container.Started        
    }

    It "Gets the connectionstring" {
        $global:container.GetConnectionString() | Should -Not -BeNullOrEmpty
    }

    It "Runs a script" {
        $scriptContent = "SELECT 1"
        ($global:container | Write-MsSqlScript -ScriptContent $scriptContent).Stdout | Should -Match "\s*1\s*"
    }

    It "Stops the MsSqlContainer" {
        $global:container | Stop-Container
        Wait-Event Container.Stopped
        $global:container.IsRunning | Should -BeFalse
    }

    It "Removes the MsSqlContainer" {
        
        $global:container | Remove-Container
    }

    AfterAll {
        Unregister-Event "Container.Started" -ErrorAction SilentlyContinue
        Unregister-Event "Container.Stopped" -ErrorAction SilentlyContinue
    }
}