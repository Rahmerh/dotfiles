Write-Host "Installing all applications." -ForegroundColor "Cyan";

winget import "$PSScriptRoot\Winget-Export.json"
