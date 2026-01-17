<#
.SYNOPSIS
    Example 4: MongoDB for Document Storage

.DESCRIPTION
    Demonstrates using MongoDB container for document database operations.
    Shows how to get connection URI for MongoDB drivers.
#>

# Import the MongoDB module
Import-Module TestcontainersPwsh.MongoDb

# Start MongoDB
$mongo = New-MongoDbContainer
$mongo | Start-Container

# Get connection string for MongoDB driver
$mongoUri = $mongo.GetConnectionString()
Write-Host "MongoDB URI: $mongoUri" -ForegroundColor Green

# Example: Use with MongoDB.Driver
# Uncomment the following lines if you have MongoDB.Driver installed:
#
# Add-Type -Path "path\to\MongoDB.Driver.dll"
# Add-Type -Path "path\to\MongoDB.Bson.dll"
# 
# $client = New-Object MongoDB.Driver.MongoClient($mongoUri)
# $database = $client.GetDatabase("testdb")
# $collection = $database.GetCollection("users")
# 
# # Insert a document
# $document = @{
#     name = "John Doe"
#     email = "john@example.com"
#     age = 30
# }
# $bsonDocument = [MongoDB.Bson.BsonDocument]::new($document)
# $collection.InsertOne($bsonDocument)
# 
# # Query documents
# $filter = [MongoDB.Driver.Builders]::Filter.Empty
# $results = $collection.Find($filter).ToList()
# Write-Host "Documents in collection: $($results.Count)"

Write-Host "`nContainer Information:" -ForegroundColor Cyan
Write-Host "  Container ID: $($mongo.Id)"
Write-Host "  Is Running: $($mongo.IsRunning)"
Write-Host "  Image: $($mongo.Image.FullName)"

# Cleanup
Write-Host "`nCleaning up..." -ForegroundColor Yellow
$mongo | Stop-Container
$mongo | Remove-Container

Write-Host "MongoDB container removed successfully!" -ForegroundColor Green
