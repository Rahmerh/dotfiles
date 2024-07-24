Write-Host "Starting lf installation/configuration" -ForegroundColor "Cyan";

$DotfilesLfFolder = Join-Path -Path $HOME -ChildPath ".dotfiles" | Join-Path -ChildPath "windows" | Join-Path -ChildPath "lf" | Join-Path -ChildPath "configuration";

$LfFolder = Join-Path -Path $env:LOCALAPPDATA -ChildPath lf
function Set-Lf-Configuration
{
    if(Test-Path -Path $LfFolder)
    {
        Write-Host "Removing lf configuration folder" -ForegroundColor "Cyan";
        Remove-Item -R $LfFolder -Force
    }

    Copy-Item -R $DotfilesLfFolder $LfFolder
}

Set-Lf-Configuration;

Write-Host "Finished lf configuration." -ForegroundColor "Green";
