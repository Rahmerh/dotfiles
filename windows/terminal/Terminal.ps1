Write-Host "Starting terminal configuration" -ForegroundColor "Cyan";

$DotfilesTerminalFolder = Join-Path -Path $HOME -ChildPath ".dotfiles" | Join-Path -ChildPath "windows" | Join-Path -ChildPath "terminal";
$TerminalLocalStateFolder = Join-Path -Path $env:LOCALAPPDATA -ChildPath "Packages" | Join-Path -ChildPath "Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe" | Join-Path -ChildPath "LocalState"

Copy-Item -Path "$DotfilesTerminalFolder\\settings.json" -Destination $TerminalLocalStateFolder -Force

Write-Host "Finished terminal configuration." -ForegroundColor "Green";
