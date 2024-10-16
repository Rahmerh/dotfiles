Write-Host "Starting terminal configuration" -ForegroundColor "Cyan";

$DotfilesTerminalFolder = Join-Path -Path $HOME -ChildPath ".dotfiles" | Join-Path -ChildPath "windows" | Join-Path -ChildPath "terminal";
$TerminalLocalStateFolder = "$HOME\scoop\apps\windows-terminal-preview\current\settings"

Copy-Item -Path "$DotfilesTerminalFolder\\settings.json" -Destination $TerminalLocalStateFolder -Force

Write-Host "Finished terminal configuration." -ForegroundColor "Green";
