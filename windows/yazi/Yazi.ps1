Write-Host "Starting yazi installation/configuration" -ForegroundColor "Cyan";

$DotfilesYaziFolder = Join-Path -Path $HOME -ChildPath ".dotfiles" | Join-Path -ChildPath "windows" | Join-Path -ChildPath "yazi" | Join-Path -ChildPath "configuration";

$YaziConfigurationFolder = Join-Path -Path "$env:APPDATA" -ChildPath yazi | Join-Path -ChildPath config

Copy-Item -Recurse -Force "$DotfilesYaziFolder\*" $YaziConfigurationFolder

Write-Host "Finished yazi configuration." -ForegroundColor "Green";
