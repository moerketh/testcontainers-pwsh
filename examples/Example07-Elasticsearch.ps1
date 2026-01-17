<#
.SYNOPSIS
    Example 7: Elasticsearch for Search

.DESCRIPTION
    Demonstrates setting up Elasticsearch for search and analytics.
    Shows how to use the REST API for basic operations.
#>

# Import the Elasticsearch module
Import-Module TestcontainersPwsh.Elasticsearch

# Start Elasticsearch
Write-Host "Starting Elasticsearch container (this may take a minute)..." -ForegroundColor Yellow
$elastic = New-ElasticsearchContainer
$elastic | Start-Container

# Get connection string
$esUrl = $elastic.GetConnectionString()
Write-Host "`nElasticsearch URL: $esUrl" -ForegroundColor Green

# Test with REST API
Write-Host "`nTesting Elasticsearch cluster health..." -ForegroundColor Cyan
try {
    $health = Invoke-RestMethod -Uri "$esUrl/_cluster/health" -Method Get
    Write-Host "Cluster Status: $($health.status)" -ForegroundColor Green
    Write-Host "Cluster Name: $($health.cluster_name)"
    Write-Host "Number of Nodes: $($health.number_of_nodes)"
}
catch {
    Write-Host "Error connecting to Elasticsearch: $_" -ForegroundColor Red
}

# Example: Index a document
Write-Host "`nIndexing a sample document..." -ForegroundColor Cyan
try {
    $document = @{
        title = "Test Document"
        content = "This is a test document for Elasticsearch"
        timestamp = Get-Date -Format "o"
    } | ConvertTo-Json

    $response = Invoke-RestMethod -Uri "$esUrl/test-index/_doc/1" -Method Put -Body $document -ContentType "application/json"
    Write-Host "Document indexed: $($response.result)" -ForegroundColor Green
}
catch {
    Write-Host "Error indexing document: $_" -ForegroundColor Red
}

# Example: Search for documents
Write-Host "`nSearching for documents..." -ForegroundColor Cyan
try {
    Start-Sleep -Seconds 2  # Wait for indexing to complete
    $searchResults = Invoke-RestMethod -Uri "$esUrl/test-index/_search" -Method Get
    Write-Host "Total hits: $($searchResults.hits.total.value)" -ForegroundColor Green
}
catch {
    Write-Host "Error searching: $_" -ForegroundColor Red
}

# Cleanup
Write-Host "`nCleaning up..." -ForegroundColor Yellow
$elastic | Stop-Container
$elastic | Remove-Container

Write-Host "Elasticsearch container removed successfully!" -ForegroundColor Green
