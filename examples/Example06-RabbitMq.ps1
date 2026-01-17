<#
.SYNOPSIS
    Example 6: RabbitMQ for Message Queuing

.DESCRIPTION
    Demonstrates setting up RabbitMQ for AMQP message queuing.
    Shows connection details and management UI information.
#>

# Import the RabbitMQ module
Import-Module TestcontainersPwsh.RabbitMq

# Start RabbitMQ
Write-Host "Starting RabbitMQ container..." -ForegroundColor Yellow
$rabbitmq = New-RabbitMqContainer
$rabbitmq | Start-Container

# Get connection details
$amqpUrl = $rabbitmq.GetConnectionString()
Write-Host "`nRabbitMQ AMQP URL: $amqpUrl" -ForegroundColor Green

# Example: Access management UI
Write-Host "`nManagement UI Information:" -ForegroundColor Cyan
Write-Host "  Default credentials: guest/guest"
Write-Host "  Access the web UI at the mapped port (check container port mapping)"

# Example: Use with RabbitMQ.Client
# Uncomment the following lines if you have RabbitMQ.Client installed:
#
# Add-Type -Path "path\to\RabbitMQ.Client.dll"
# 
# $factory = New-Object RabbitMQ.Client.ConnectionFactory
# $factory.Uri = [System.Uri]::new($amqpUrl)
# 
# $connection = $factory.CreateConnection()
# $channel = $connection.CreateModel()
# 
# # Declare a queue
# $channel.QueueDeclare("test-queue", $true, $false, $false, $null)
# 
# # Publish a message
# $body = [System.Text.Encoding]::UTF8.GetBytes("Hello RabbitMQ!")
# $channel.BasicPublish("", "test-queue", $null, $body)
# Write-Host "Message published to queue!"
# 
# $channel.Close()
# $connection.Close()

Write-Host "`nContainer Details:" -ForegroundColor Cyan
Write-Host "  Container ID: $($rabbitmq.Id)"
Write-Host "  Is Running: $($rabbitmq.IsRunning)"

# Cleanup
Write-Host "`nCleaning up..." -ForegroundColor Yellow
$rabbitmq | Stop-Container
$rabbitmq | Remove-Container

Write-Host "RabbitMQ container removed successfully!" -ForegroundColor Green
