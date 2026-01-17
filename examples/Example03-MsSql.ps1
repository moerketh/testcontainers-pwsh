<#
.SYNOPSIS
    Example 3: MS SQL Server with Script Execution

.DESCRIPTION
    Demonstrates executing SQL scripts against a temporary SQL Server container.
    Shows how to create databases, tables, and query data.
#>

# Import the MS SQL module
Import-Module TestcontainersPwsh.MsSql

# Create and start SQL Server
$sqlServer = New-MsSqlContainer
$sqlServer | Start-Container

Write-Host "SQL Server started successfully!" -ForegroundColor Green
Write-Host "Connection String: $($sqlServer.GetConnectionString())" -ForegroundColor Cyan

# Execute a SQL script
$scriptContent = @"
CREATE DATABASE TestDB;
GO
USE TestDB;
GO
CREATE TABLE Users (
    Id INT PRIMARY KEY,
    Name NVARCHAR(50),
    Email NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO
INSERT INTO Users (Id, Name, Email) VALUES 
    (1, 'Alice Johnson', 'alice@example.com'),
    (2, 'Bob Smith', 'bob@example.com'),
    (3, 'Charlie Brown', 'charlie@example.com');
GO
SELECT * FROM Users;
GO
SELECT 'Total Users: ' + CAST(COUNT(*) AS VARCHAR) AS Summary FROM Users;
"@

Write-Host "`nExecuting SQL script..." -ForegroundColor Yellow
$result = $sqlServer | Write-MsSqlScript -ScriptContent $scriptContent

Write-Host "`nScript Output:" -ForegroundColor Green
Write-Host $result.Stdout

if ($result.Stderr) {
    Write-Host "`nScript Errors:" -ForegroundColor Red
    Write-Host $result.Stderr
}

# Cleanup
Write-Host "`nCleaning up..." -ForegroundColor Yellow
$sqlServer | Stop-Container
$sqlServer | Remove-Container

Write-Host "SQL Server container removed successfully!" -ForegroundColor Green
