# Examples

This directory contains practical examples demonstrating how to use TestContainersPwsh modules.

## Prerequisites

Before running these examples:

1. Ensure Docker is running:
   ```powershell
   docker ps
   ```

2. Build and install the modules:
   ```powershell
   .\Install.ps1
   ```

## Available Examples

| Example | File | Description |
|---------|------|-------------|
| **Example 1** | `Example01-Redis.ps1` | Basic Redis container lifecycle management |
| **Example 2** | `Example02-PostgreSql.ps1` | PostgreSQL database container with connection details |
| **Example 3** | `Example03-MsSql.ps1` | MS SQL Server with script execution capabilities |
| **Example 4** | `Example04-MongoDb.ps1` | MongoDB document database setup |
| **Example 5** | `Example05-Kafka.ps1` | Apache Kafka event streaming platform |
| **Example 6** | `Example06-RabbitMq.ps1` | RabbitMQ message broker with AMQP |
| **Example 7** | `Example07-Elasticsearch.ps1` | Elasticsearch search engine with REST API |
| **Example 8** | `Example08-Azurite.ps1` | Azure Storage emulator (Blob, Queue, Table) |
| **Example 9** | `Example09-ContainerEvents.ps1` | Async event handling for container lifecycle |
| **Example 10** | `Example10-CustomBuilder.ps1` | Advanced builder API for custom containers |

## Running Examples

### Run a Single Example

```powershell
# Navigate to the examples directory
cd examples

# Run an example
.\Example01-Redis.ps1
```

### Run All Examples

```powershell
Get-ChildItem .\examples\*.ps1 | ForEach-Object {
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host "Running: $($_.Name)" -ForegroundColor Cyan
    Write-Host "========================================`n" -ForegroundColor Cyan
    & $_.FullName
}
```

## Example Categories

### Basic Containers (Examples 1-4)
These examples demonstrate basic container operations:
- Creating containers
- Starting and stopping
- Getting connection strings
- Cleanup and disposal

### Messaging & Streaming (Examples 5-6)
Event-driven architecture examples:
- Kafka for event streaming
- RabbitMQ for message queuing

### Storage & Search (Examples 7-8)
Data persistence and search:
- Elasticsearch for full-text search
- Azurite for Azure Storage emulation

### Advanced Patterns (Examples 9-10)
More sophisticated usage:
- Event-driven async patterns
- Custom container builder API

## Notes

- Each example is self-contained and includes cleanup
- Examples show connection patterns but may require additional client libraries for full functionality
- Some examples may take a minute to start (Kafka, Elasticsearch)
- All containers are automatically removed after example completion