Write-Host "Installing all applications." -ForegroundColor "Cyan";

winget import "$PSScriptRoot\Winget-Export.json"

# Don't need this, we're using the preview
winget uninstall Microsoft.WindowsTerminal
