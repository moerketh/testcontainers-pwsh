<#
.SYNOPSIS
    Example 9: Container Lifecycle Events

.DESCRIPTION
    Demonstrates using PowerShell events to handle container lifecycle asynchronously.
    Shows event registration, waiting, and cleanup patterns.
#>

# Import the Redis module
Import-Module TestcontainersPwsh.Redis

Write-Host "Setting up container with event handlers..." -ForegroundColor Yellow

$container = New-RedisContainer

# Register event handlers
Write-Host "`nRegistering event handlers..." -ForegroundColor Cyan

Register-ObjectEvent -InputObject $container -EventName 'Started' -SourceIdentifier 'Redis.Started' -Action {
    $timestamp = Get-Date -Format "HH:mm:ss"
    Write-Host "[$timestamp] ✓ Redis container started!" -ForegroundColor Green
}

Register-ObjectEvent -InputObject $container -EventName 'Stopped' -SourceIdentifier 'Redis.Stopped' -Action {
    $timestamp = Get-Date -Format "HH:mm:ss"
    Write-Host "[$timestamp] ✓ Redis container stopped!" -ForegroundColor Yellow
}

# Start and wait for event
Write-Host "`nStarting container..." -ForegroundColor Cyan
$container | Start-Container

Write-Host "Waiting for 'Started' event..." -ForegroundColor Gray
$startedEvent = Wait-Event -SourceIdentifier 'Redis.Started' -Timeout 30

if ($startedEvent) {
    Remove-Event -EventIdentifier $startedEvent.EventIdentifier
    Write-Host "Container started successfully!" -ForegroundColor Green
    
    # Do some work
    $connectionString = $container.GetConnectionString()
    Write-Host "`nConnection String: $connectionString" -ForegroundColor Cyan
    Write-Host "Container ID: $($container.Id)" -ForegroundColor Cyan
    
    Write-Host "`nSimulating work for 3 seconds..." -ForegroundColor Gray
    Start-Sleep -Seconds 3
}
else {
    Write-Host "Timeout waiting for container to start!" -ForegroundColor Red
}

# Stop and wait for event
Write-Host "`nStopping container..." -ForegroundColor Cyan
$container | Stop-Container

Write-Host "Waiting for 'Stopped' event..." -ForegroundColor Gray
$stoppedEvent = Wait-Event -SourceIdentifier 'Redis.Stopped' -Timeout 30

if ($stoppedEvent) {
    Remove-Event -EventIdentifier $stoppedEvent.EventIdentifier
    Write-Host "Container stopped successfully!" -ForegroundColor Yellow
}
else {
    Write-Host "Timeout waiting for container to stop!" -ForegroundColor Red
}

# Cleanup
Write-Host "`nCleaning up..." -ForegroundColor Cyan
$container | Remove-Container

# Unregister events
Unregister-Event -SourceIdentifier 'Redis.Started' -ErrorAction SilentlyContinue
Unregister-Event -SourceIdentifier 'Redis.Stopped' -ErrorAction SilentlyContinue

Write-Host "`n✓ Example completed successfully!" -ForegroundColor Green
Write-Host "`nKey Takeaways:" -ForegroundColor Cyan
Write-Host "  - Events allow async handling of container lifecycle"
Write-Host "  - Use Wait-Event to block until an event occurs"
Write-Host "  - Always unregister events to prevent memory leaks"
Write-Host "  - Remove processed events with Remove-Event"
