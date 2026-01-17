<#
.SYNOPSIS
    Example 5: Kafka for Event Streaming

.DESCRIPTION
    Demonstrates setting up a Kafka container for message streaming.
    Includes Zookeeper and shows how to get bootstrap server addresses.
#>

# Import the Kafka module
Import-Module TestcontainersPwsh.Kafka

# Start Kafka (includes Zookeeper)
Write-Host "Starting Kafka container (this may take a minute)..." -ForegroundColor Yellow
$kafka = New-KafkaContainer
$kafka | Start-Container

# Get bootstrap servers
$bootstrapServers = $kafka.GetBootstrapAddress()
Write-Host "`nKafka brokers: $bootstrapServers" -ForegroundColor Green

# Example: Use with Confluent.Kafka
# Uncomment the following lines if you have Confluent.Kafka installed:
#
# Add-Type -Path "path\to\Confluent.Kafka.dll"
# 
# # Producer configuration
# $producerConfig = @{
#     'bootstrap.servers' = $bootstrapServers
# }
# 
# $producer = New-Object Confluent.Kafka.ProducerBuilder($producerConfig).Build()
# 
# # Produce a message
# $message = New-Object Confluent.Kafka.Message
# $message.Key = "key1"
# $message.Value = "Hello Kafka!"
# $producer.ProduceAsync("test-topic", $message).Wait()
# 
# Write-Host "Message sent to Kafka!"
# $producer.Dispose()

Write-Host "`nContainer Details:" -ForegroundColor Cyan
Write-Host "  Container ID: $($kafka.Id)"
Write-Host "  Is Running: $($kafka.IsRunning)"

# Cleanup
Write-Host "`nCleaning up..." -ForegroundColor Yellow
$kafka | Stop-Container
$kafka | Remove-Container

Write-Host "Kafka container removed successfully!" -ForegroundColor Green
