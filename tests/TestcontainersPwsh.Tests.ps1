. $PSScriptRoot\TestBase.ps1

Describe "Pester Version Check" {
    Context "When Pester version is less than 5.5" {
        It "Should throw an error" {
            $pesterVersion = (Get-Module -ListAvailable Pester).Version
            $minimumVersion = [Version]"5.5"

            if ($pesterVersion -lt $minimumVersion) {
                throw "Pester version $($pesterVersion) is lower than the required minimum version $($minimumVersion)"
            }
        }
    }
}

Describe 'Get-ContainerWaitStrategy' {

    BeforeAll {
        Add-Type -Path "$PSScriptRoot\..\src\TestcontainersPwsh\bin\debug\net8.0\testcontainers.dll"
    }

    It 'returns WaitForContainerWindows for -ForWindowsContainer' {
        $result = Get-ContainerWaitStrategy -ForWindowsContainer
        $result | Should -Not -BeNullOrEmpty
        $result.GetType().FullName -eq "DotNet.Testcontainers.Configurations.WaitForContainerWindows" | Should -Be $true
    }
    
    It 'returns WaitForContainerUnix for -ForUnixContainer' {
        $result = Get-ContainerWaitStrategy -ForUnixContainer
        $result | Should -Not -BeNullOrEmpty
        $result.GetType().FullName -eq "DotNet.Testcontainers.Configurations.WaitForContainerUnix" | Should -Be $true
    }
    

    It 'throws an error when both -ForWindowsContainer and -ForUnixContainer are specified' {
        { Get-ContainerWaitStrategy -ForWindowsContainer -ForUnixContainer } | Should -Throw -ExpectedMessage 'Cannot process command because both -ForWindowsContainer and -ForUnixContainer options were given. Please specify only one.'
    }

    It 'throws an error when neither -ForWindowsContainer nor -ForUnixContainer is specified' {
        { Get-ContainerWaitStrategy } | Should -Throw -ExpectedMessage 'Cannot process command because neither -ForWindowsContainer nor -ForUnixContainer options were given. Please specify one.'
    }
}


Describe "ContainerBuilder Tests" {
    BeforeAll {
        #Create data file
        $initPath = "TestDrive:\init.csv"
        Set-Content $initPath -value "a,b"

        # Create a new Container
        $global:container = New-ContainerBuilder
        | Set-ContainerImage -Image "mcr.microsoft.com/azuredataexplorer/kustainer-linux:latest"
        | Set-ContainerName -Name "adxSystemTest"
        | Set-ContainerPortBinding -HostPort 8080 -ContainerPort 8080
        | Set-ContainerWaitStrategy -WaitStrategy ((Get-ContainerWaitStrategy -ForUnixContainer).UntilPortIsAvailable(8080))
        | Set-ContainerResourceMapping -Source "$TestDrive\init.csv" -Target "/data/init.csv"
        | Set-ContainerEnvironment -Name "ACCEPT_EULA" -Value "Y"
        | Set-ContainerAutoRemove -AutoRemove $true
        | Start-ContainerBuild

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

    It "Builds a container with the correct configuration" {
        $global:container.Image.FullName | Should -Be "mcr.microsoft.com/azuredataexplorer/kustainer-linux:latest"
    }

    It "Starts the container" {
        
        $global:container | Start-Container
        Wait-Event Container.Started
        $global:container.Name | Should -Be "/adxSystemTest"
    }

    It "Stops the Container" {     
        $container | Stop-Container
        Wait-Event Container.Stopped        
    }

    AfterAll {
        Unregister-Event "Container.Started" -ErrorAction SilentlyContinue
        Unregister-Event "Container.Stopped" -ErrorAction SilentlyContinue
    }
}