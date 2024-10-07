try {
    if(-not (Get-Module -Name TestcontainersPwsh)) {
        Import-Module -Name "$PSScriptRoot\..\src\TestcontainersPwsh\TestcontainersPwsh.psd1" -Force
    }
} catch {
    if ($_.Exception -is [System.Reflection.ReflectionTypeLoadException]) {
        $exception = $_.Exception
        Write-Host "ReflectionTypeLoadException: $($exception.Message)"
        Write-Host "LoaderExceptions:"
        foreach ($loaderException in $exception.LoaderExceptions) {
            Write-Host "    $loaderException"
        }
    }
    throw $_
}
