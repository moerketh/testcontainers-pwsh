<#
.SYNOPSIS
    Example 10: Advanced Container Builder

.DESCRIPTION
    Demonstrates using the low-level builder API for custom container configurations.
    Shows how to build containers with custom images, ports, environment variables, and wait strategies.
#>

# Import the core module
Import-Module TestcontainersPwsh

Write-Host "Building a custom Nginx container..." -ForegroundColor Yellow

# Create a custom container configuration
$builder = New-ContainerBuilder

# Configure the container
$builder | Set-ContainerImage -Image "nginx:alpine"
$builder | Set-ContainerName -Name "my-custom-nginx"
$builder | Set-ContainerPortBinding -Port 80 -HostPort 8080
$builder | Set-ContainerEnvironment -Name "NGINX_HOST" -Value "localhost"
$builder | Set-ContainerEnvironment -Name "NGINX_PORT" -Value "80"
$builder | Set-ContainerAutoRemove -AutoRemove $true

Write-Host "  ✓ Image: nginx:alpine" -ForegroundColor Green
Write-Host "  ✓ Port: 80 -> 8080" -ForegroundColor Green
Write-Host "  ✓ Environment variables configured" -ForegroundColor Green
Write-Host "  ✓ Auto-remove enabled" -ForegroundColor Green

# Add a wait strategy
Write-Host "`nConfiguring wait strategy..." -ForegroundColor Cyan
$waitStrategy = Get-ContainerWaitStrategy -Type HttpWaitStrategy -Path "/" -Port 80
$builder | Set-ContainerWaitStrategy -WaitStrategy $waitStrategy
Write-Host "  ✓ HTTP wait strategy on port 80" -ForegroundColor Green

# Build the container
Write-Host "`nBuilding container..." -ForegroundColor Cyan
$container = $builder | Start-ContainerBuild
Write-Host "  ✓ Container built successfully" -ForegroundColor Green

# Start the container
Write-Host "`nStarting container..." -ForegroundColor Cyan
$container | Start-Container
Write-Host "  ✓ Container started" -ForegroundColor Green

# Access nginx
Write-Host "`nTesting Nginx..." -ForegroundColor Cyan
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8080" -Method Get -TimeoutSec 10
    Write-Host "  ✓ HTTP Status: $($response.StatusCode)" -ForegroundColor Green
    Write-Host "  ✓ Nginx is responding!" -ForegroundColor Green
}
catch {
    Write-Host "  ✗ Error accessing Nginx: $_" -ForegroundColor Red
}

# Display container information
Write-Host "`nContainer Information:" -ForegroundColor Cyan
Write-Host "  Container ID: $($container.Id)"
Write-Host "  Container Name: $($container.Name)"
Write-Host "  Is Running: $($container.IsRunning)"
Write-Host "  Image: $($container.Image.FullName)"

# Cleanup
Write-Host "`nCleaning up..." -ForegroundColor Yellow
$container | Stop-Container
$container | Remove-Container
Write-Host "  ✓ Container removed" -ForegroundColor Green

Write-Host "`n✓ Example completed successfully!" -ForegroundColor Green
Write-Host "`nKey Takeaways:" -ForegroundColor Cyan
Write-Host "  - Builder API provides fine-grained control over containers"
Write-Host "  - Chain Set-Container* cmdlets to configure the builder"
Write-Host "  - Wait strategies ensure container is ready before use"
Write-Host "  - Perfect for custom images and complex configurations"
