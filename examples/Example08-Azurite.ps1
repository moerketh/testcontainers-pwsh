<#
.SYNOPSIS
    Example 8: Azurite for Azure Storage Emulation

.DESCRIPTION
    Demonstrates using Azurite as an Azure Storage emulator.
    Shows how to get connection strings for Blob, Queue, and Table services.
#>

# Import the Azurite module
Import-Module TestcontainersPwsh.Azurite

# Start Azurite (Azure Storage Emulator)
Write-Host "Starting Azurite container..." -ForegroundColor Yellow
$azurite = New-AzuriteContainer
$azurite | Start-Container

# Get connection string
$storageConnStr = $azurite.GetConnectionString()
Write-Host "`nAzure Storage connection string:" -ForegroundColor Green
Write-Host $storageConnStr

# Example: Use with Azure.Storage.Blobs
# Uncomment the following lines if you have Azure.Storage.Blobs installed:
#
# Add-Type -Path "path\to\Azure.Storage.Blobs.dll"
# 
# $blobServiceClient = New-Object Azure.Storage.Blobs.BlobServiceClient($storageConnStr)
# 
# # Create a container
# $containerName = "test-container"
# $containerClient = $blobServiceClient.GetBlobContainerClient($containerName)
# $containerClient.CreateIfNotExists()
# 
# Write-Host "Container '$containerName' created"
# 
# # Upload a blob
# $blobName = "test.txt"
# $blobClient = $containerClient.GetBlobClient($blobName)
# $content = [System.Text.Encoding]::UTF8.GetBytes("Hello Azurite!")
# $stream = New-Object System.IO.MemoryStream(,$content)
# $blobClient.Upload($stream, $true)
# 
# Write-Host "Blob '$blobName' uploaded"
# 
# # List blobs
# $blobs = $containerClient.GetBlobs()
# Write-Host "`nBlobs in container:"
# foreach ($blob in $blobs) {
#     Write-Host "  - $($blob.Name)"
# }

Write-Host "`nAzurite Services Available:" -ForegroundColor Cyan
Write-Host "  - Blob Service"
Write-Host "  - Queue Service"
Write-Host "  - Table Service"

Write-Host "`nContainer Details:" -ForegroundColor Cyan
Write-Host "  Container ID: $($azurite.Id)"
Write-Host "  Is Running: $($azurite.IsRunning)"

# Cleanup
Write-Host "`nCleaning up..." -ForegroundColor Yellow
$azurite | Stop-Container
$azurite | Remove-Container

Write-Host "Azurite container removed successfully!" -ForegroundColor Green
