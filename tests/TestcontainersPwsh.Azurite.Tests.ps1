. $PSScriptRoot\TestBase.ps1

Describe "AzuriteContainer Cmdlets Tests" {
    BeforeAll {
        # Import Azure.Storage.Blobs assembly for connection tests
        Add-Type -Path "$PSScriptRoot\..\src\TestcontainersPwsh.Azurite\bin\Debug\net8.0\Azure.Storage.Blobs.dll" -ErrorAction SilentlyContinue
        
        try {
            Import-Module -Name "$PSScriptRoot\..\src\TestcontainersPwsh.Azurite\TestcontainersPwsh.Azurite.psd1" -Force
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
        $global:container = New-AzuriteContainer

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

    It "Creates a new AzuriteContainer" {
        $global:container | Should -Not -BeNullOrEmpty
    }

    It "Starts AzuriteContainer" {
        $global:container | Start-Container
        Wait-Event Container.Started

        $localStartedTime = $container.StartedTime.ToLocalTime()
        $now = Get-Date
        $localStartedTime | Should -BeGreaterThan ($now.AddMinutes(-1))
        $localStartedTime | Should -BeLessThan $now
    }

    It "Gets blob service connection string" {
        $global:container.GetConnectionString() | Should -Not -BeNullOrEmpty
    }

    It "Connects to AzuriteContainer" {
        # Import Azure.Storage.Blobs to test connection
        $connString = $global:container.GetConnectionString()

        # Create a blob service client and test
        $blobServiceClient = [Azure.Storage.Blobs.BlobServiceClient]::new($connString)
        $containerName = "test-container"

        # Create a container - use CreateBlobContainerAsync since it's async
        $blobContainerResponse = $blobServiceClient.CreateBlobContainerAsync($containerName).GetAwaiter().GetResult()
        $blobContainer = $blobContainerResponse.Value

        # Upload a blob
        $blobName = "test-blob.txt"
        $blobContent = [System.Text.Encoding]::UTF8.GetBytes("test content")
        $blobContainer.UploadBlob($blobName, [System.IO.MemoryStream]::new($blobContent))

        # Download the blob and verify content
        $downloadedContentResponse = $blobContainer.GetBlobClient($blobName).DownloadContentAsync().GetAwaiter().GetResult()
        $downloadedContent = $downloadedContentResponse.Value
        $downloadedContent.Content.ToString() | Should -Be "test content"

        $blobServiceClient.DeleteBlobContainer($containerName)
    }

    It "Stops AzuriteContainer" {
        $global:container | Stop-Container
        Wait-Event Container.Stopped
        $global:container.IsRunning | Should -BeFalse
    }

    It "Removes AzuriteContainer" {
        $global:container | Remove-Container
    }

    AfterAll {
        Unregister-Event "Container.Started" -ErrorAction SilentlyContinue
        Unregister-Event "Container.Stopped" -ErrorAction SilentlyContinue
    }
}
