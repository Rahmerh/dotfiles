Write-Host "Starting lf installation/configuration" -ForegroundColor "Cyan";

$DotfilesLfFolder = Join-Path -Path $HOME -ChildPath ".dotfiles" | Join-Path -ChildPath "windows" | Join-Path -ChildPath "lf" | Join-Path -ChildPath "configuration";

$LfFolder = Join-Path -Path $env:LOCALAPPDATA -ChildPath lf

Copy-Item -Recurse -Force $DotfilesLfFolder $LfFolder

Write-Host "Finished lf configuration." -ForegroundColor "Green";
