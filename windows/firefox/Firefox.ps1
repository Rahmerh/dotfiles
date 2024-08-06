Write-Host "Starting firefox installation/configuration" -ForegroundColor "Cyan";

$DotfilesFirefoxChromeFolder = Join-Path -Path $HOME -ChildPath ".dotfiles" | Join-Path -ChildPath "windows" | Join-Path -ChildPath "firefox" | Join-Path -ChildPath "chrome";

$FirefoxProfilesFolder = Join-Path -Path "$env:APPDATA" -ChildPath Mozilla | Join-Path -ChildPath Firefox | Join-Path -ChildPath Profiles | Join-Path -ChildPath "*.default-release"

$FirefoxReleaseProfileFolder = Resolve-Path $FirefoxProfilesFolder | Select -ExpandProperty Path

Copy-Item -Recurse -Force $DotfilesFirefoxChromeFolder $FirefoxReleaseProfileFolder

Write-Host "Finished firefox configuration." -ForegroundColor "Green";
