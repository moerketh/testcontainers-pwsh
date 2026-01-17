# TestContainersPwsh

A PowerShell module that wraps [testcontainers-dotnet](https://github.com/testcontainers/testcontainers-dotnet), providing PowerShell cmdlets for managing containerized services in your development and testing workflows.

## Features

- **Multiple Database Engines**: PostgreSQL, MySQL, MS SQL Server, MongoDB, CosmosDB, Redis
- **Messaging Systems**: Kafka, RabbitMQ
- **Storage Solutions**: Minio, Azurite
- **Search & Analytics**: Elasticsearch, Kusto
- **Infrastructure**: Kubernetes (K3s), Keycloak
- **PowerShell Native**: Cmdlets that follow PowerShell conventions and pipeline patterns
- **Event-Driven**: Container lifecycle events (Started, Stopped) for async workflows

## Why Use This Module?

**Without TestContainersPwsh** (using testcontainers-dotnet directly):
```powershell
Add-Type -Path "$PSScriptRoot\src\TestcontainersPwsh.Kusto\bin\Debug\net8.0\Testcontainers.Kusto.dll"
$container = (New-Object -TypeName Testcontainers.Kusto.KustoBuilder).Build()
$container.StartAsync().GetAwaiter().GetResult()
Invoke-WebRequest -Uri $container.GetConnectionString() -Method Get
$container.StopAsync().GetAwaiter().GetResult()
$container.DisposeAsync().AsTask().Wait()
```

**With TestContainersPwsh** (PowerShell-native cmdlets):
```powershell
Import-Module TestcontainersPwsh.Kusto
$container = New-KustoContainer
$container | Start-Container
Invoke-WebRequest -Uri $container.GetConnectionString() -Method Get
$container | Stop-Container
$container | Remove-Container
```

**Benefits:**
- No manual DLL loading or type handling
- Clean, idiomatic PowerShell syntax
- Pipeline support for chaining operations
- Consistent cmdlet naming (Verb-Noun pattern)
- Simplified async operations (no `.GetAwaiter().GetResult()`)

## Prerequisites

- **PowerShell**: 7.0 or higher
- **Docker**: Docker Desktop or Docker Engine installed and running
- **.NET SDK**: .NET 8.0 SDK or higher
- **Operating System**: Windows, macOS, or Linux

### Docker Verification

Ensure Docker is running:

```powershell
docker --version
docker ps
```

## Installation

### Option 1: Build and Install from Source

1. Clone the repository:
```powershell
git clone https://github.com/your-org/TestContainersPwsh.git
cd TestContainersPwsh
```

2. Run the installation script:
```powershell
.\Install.ps1
```

This will:
- Restore NuGet packages
- Build all modules in Debug configuration
- Copy modules to your PowerShell module path

### Option 2: Manual Build

```powershell
dotnet restore
dotnet build -c Debug
```

Then import modules directly from the `src` directory:
```powershell
Import-Module ./src/TestcontainersPwsh.Redis/TestcontainersPwsh.Redis.psd1
```

## Quick Start

Here's a simple example to get you started:

```powershell
# Import a module
Import-Module TestcontainersPwsh.Redis

# Create and start a container
$redis = New-RedisContainer
$redis | Start-Container

# Get connection string
$connectionString = $redis.GetConnectionString()
Write-Host "Redis is running at: $connectionString"

# Use the container...

# Clean up
$redis | Stop-Container
$redis | Remove-Container
```

## Examples

For comprehensive examples, see the [examples](./examples) directory. Each example is a complete, runnable PowerShell script demonstrating specific use cases.

### Quick Reference

**Basic Containers:**
- [Example 1: Redis](./examples/Example01-Redis.ps1) - Basic container lifecycle
- [Example 2: PostgreSQL](./examples/Example02-PostgreSql.ps1) - Database with connections
- [Example 3: MS SQL Server](./examples/Example03-MsSql.ps1) - SQL script execution
- [Example 4: MongoDB](./examples/Example04-MongoDb.ps1) - Document storage

**Messaging & Streaming:**
- [Example 5: Kafka](./examples/Example05-Kafka.ps1) - Event streaming
- [Example 6: RabbitMQ](./examples/Example06-RabbitMq.ps1) - Message queuing

**Storage & Search:**
- [Example 7: Elasticsearch](./examples/Example07-Elasticsearch.ps1) - Full-text search
- [Example 8: Azurite](./examples/Example08-Azurite.ps1) - Azure Storage emulator

**Advanced Patterns:**
- [Example 9: Container Events](./examples/Example09-ContainerEvents.ps1) - Async event handling
- [Example 10: Custom Builder](./examples/Example10-CustomBuilder.ps1) - Advanced builder API

### Running Examples

```powershell
# Run a single example
.\examples\Example01-Redis.ps1

# Or run all examples
Get-ChildItem .\examples\Example*.ps1 | ForEach-Object { & $_.FullName }
```

For detailed, runnable scripts with complete code, see the [examples](./examples) directory.

## Available Modules

| Module | Cmdlet | Description |
|--------|--------|-------------|
| **TestcontainersPwsh** | `New-ContainerBuilder`, `Start-Container`, `Stop-Container`, `Remove-Container` | Core container management cmdlets |
| **TestcontainersPwsh.Azurite** | `New-AzuriteContainer` | Azure Storage emulator |
| **TestcontainersPwsh.CosmosDb** | `New-CosmosDbContainer` | Azure CosmosDB emulator |
| **TestcontainersPwsh.Elasticsearch** | `New-ElasticsearchContainer` | Elasticsearch search engine |
| **TestcontainersPwsh.K3s** | `New-K3sContainer` | Lightweight Kubernetes |
| **TestcontainersPwsh.Kafka** | `New-KafkaContainer` | Apache Kafka message broker |
| **TestcontainersPwsh.Keycloak** | `New-KeycloakContainer` | Identity and access management |
| **TestcontainersPwsh.Kusto** | `New-KustoContainer` | Azure Data Explorer (Kusto) |
| **TestcontainersPwsh.Minio** | `New-MinioContainer` | S3-compatible object storage |
| **TestcontainersPwsh.MongoDb** | `New-MongoDbContainer` | MongoDB document database |
| **TestcontainersPwsh.MsSql** | `New-MsSqlContainer`, `Write-MsSqlScript` | Microsoft SQL Server |
| **TestcontainersPwsh.MySql** | `New-MySqlContainer` | MySQL relational database |
| **TestcontainersPwsh.PostgreSql** | `New-PostgreSqlContainer` | PostgreSQL database |
| **TestcontainersPwsh.RabbitMq** | `New-RabbitMqContainer` | RabbitMQ message broker |
| **TestcontainersPwsh.Redis** | `New-RedisContainer` | Redis in-memory data store |

## Common Cmdlets

All container modules support these core operations:

- `Start-Container`: Start a container asynchronously
- `Stop-Container`: Stop a running container
- `Remove-Container`: Remove and dispose of a container
- `GetConnectionString()`: Get the connection string/URL for the service (method on container object)

## Testing

Run the test suite with Pester:

```powershell
# Install Pester if needed
Install-Module -Name Pester -Force -SkipPublisherCheck

# Run all tests
Invoke-Pester ./tests/

# Run specific module tests
Invoke-Pester ./tests/TestcontainersPwsh.Redis.Tests.ps1
```

## Project Structure

```
TestContainersPwsh/
├── .github/
│   └── workflows/
│       └── ci.yml                       # GitHub Actions CI workflow
├── examples/                            # Runnable example scripts
│   ├── Example01-Redis.ps1
│   ├── Example02-PostgreSql.ps1
│   └── ...
├── src/
│   ├── TestcontainersPwsh/              # Core module
│   ├── TestcontainersPwsh.Redis/        # Redis module
│   ├── TestcontainersPwsh.PostgreSql/   # PostgreSQL module
│   └── ...                              # Other service modules
├── tests/                               # Pester tests
├── Install.ps1                          # Installation script
├── LICENSE                              # MIT License
└── README.md                            # This file
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

This project wraps and builds upon the excellent [testcontainers-dotnet](https://github.com/testcontainers/testcontainers-dotnet) library, which is licensed under the MIT License.
