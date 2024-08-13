Write-Host "Starting powershell configuration" -ForegroundColor "Cyan";

$DotfilesPowershellFolder = Join-Path -Path $HOME -ChildPath ".dotfiles" | Join-Path -ChildPath "windows" | Join-Path -ChildPath "powershell";
$PowershellLocalStateFolder = Join-Path -Path $HOME -ChildPath "Documents" | Join-Path -ChildPath "Powershell"

mkdir $PowershellLocalStateFolder -ErrorAction SilentlyContinue

Copy-Item -Path "$DotfilesPowershellFolder\\Microsoft.PowerShell_profile.ps1" -Destination $PowershellLocalStateFolder -Force
Copy-Item -Path "$DotfilesPowershellFolder\\theme.json" -Destination $PowershellLocalStateFolder -Force

Write-Host "Finished powershell configuration." -ForegroundColor "Green";
