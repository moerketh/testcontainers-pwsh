& dotnet restore
& dotnet build -c Debug

$moduleSourcePath = "$PSScriptRoot"

# Get the first writable path from $env:PSModulePath
$moduleDestinationPath = ($env:PSModulePath -split ';' | Where-Object { Test-Path $_ })[0]
$moduleDestinationPath = Join-Path -Path $moduleDestinationPath -ChildPath "TestcontainersPwsh"

# Create the destination directory if it doesn't exist
if (-Not (Test-Path -Path $moduleDestinationPath)) {
    New-Item -ItemType Directory -Path $moduleDestinationPath
}

# Copy the necessary files
Copy-Item -Path "$moduleSourcePath\src\TestcontainersPwsh\TestcontainersPwsh.psm1" -Destination $moduleDestinationPath -Force
Copy-Item -Path "$moduleSourcePath\src\TestcontainersPwsh\TestcontainersPwsh.psd1" -Destination $moduleDestinationPath -Force
Copy-Item -Path "$moduleSourcePath\src\TestcontainersPwsh\bin" -Destination $moduleDestinationPath -Recurse -Force
