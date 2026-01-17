<#
.SYNOPSIS
    Example 2: PostgreSQL with Connection

.DESCRIPTION
    Demonstrates running PostgreSQL for database integration tests.
    Shows how to get connection details and connect to the database.
#>

# Import the PostgreSQL module
Import-Module TestcontainersPwsh.PostgreSql

# Create and start PostgreSQL
$postgres = New-PostgreSqlContainer
$postgres | Start-Container

# Get connection details
$connStr = $postgres.GetConnectionString()
Write-Host "PostgreSQL connection: $connStr" -ForegroundColor Green

# Example: Connect using Npgsql
# Uncomment the following lines if you have Npgsql installed:
#
# Add-Type -Path "path\to\Npgsql.dll"
# $connection = New-Object Npgsql.NpgsqlConnection($connStr)
# $connection.Open()
# 
# $command = $connection.CreateCommand()
# $command.CommandText = "SELECT version();"
# $version = $command.ExecuteScalar()
# Write-Host "PostgreSQL Version: $version"
# 
# $connection.Close()

# Alternative: Use psql command line if available
# psql $connStr -c "SELECT version();"

Write-Host "`nContainer Details:" -ForegroundColor Cyan
Write-Host "  Container ID: $($postgres.Id)"
Write-Host "  Is Running: $($postgres.IsRunning)"
Write-Host "  Started Time: $($postgres.StartedTime)"

# Cleanup
Write-Host "`nCleaning up..." -ForegroundColor Yellow
$postgres | Stop-Container
$postgres | Remove-Container

Write-Host "PostgreSQL container removed successfully!" -ForegroundColor Green
