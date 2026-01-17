<#
.SYNOPSIS
    Example 1: Redis Container for Caching

.DESCRIPTION
    Demonstrates how to spin up a Redis container for caching tests.
    This example shows basic container lifecycle management and connection string retrieval.
#>

# Import the Redis module
Import-Module TestcontainersPwsh.Redis

# Create and start a Redis container
$redis = New-RedisContainer
$redis | Start-Container

# Get the connection string
$connectionString = $redis.GetConnectionString()
Write-Host "Redis running at: $connectionString" -ForegroundColor Green

# Example: Use the container with StackExchange.Redis client
# Uncomment the following lines if you have the StackExchange.Redis package installed:
#
# Add-Type -Path "path\to\StackExchange.Redis.dll"
# $connection = [StackExchange.Redis.ConnectionMultiplexer]::Connect($connectionString)
# $db = $connection.GetDatabase()
# $db.StringSet("mykey", "Hello Redis!")
# $value = $db.StringGet("mykey")
# Write-Host "Retrieved value: $value"
# $connection.Dispose()

Write-Host "Container ID: $($redis.Id)" -ForegroundColor Cyan
Write-Host "Container is running: $($redis.IsRunning)" -ForegroundColor Cyan

# Clean up
Write-Host "`nCleaning up..." -ForegroundColor Yellow
$redis | Stop-Container
$redis | Remove-Container

Write-Host "Redis container removed successfully!" -ForegroundColor Green
