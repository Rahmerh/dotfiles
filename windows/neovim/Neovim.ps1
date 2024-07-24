Write-Host "Starting neovim installation/configuration" -ForegroundColor "Cyan";

$DotfilesNeovimFolder = Join-Path -Path $HOME -ChildPath ".dotfiles" | Join-Path -ChildPath "windows" | Join-Path -ChildPath "neovim" | Join-Path -ChildPath "nvim";

$NeovimFolder = Join-Path -Path $env:LOCALAPPDATA -ChildPath nvim
function Set-Neovim-Configuration
{
    if(Test-Path -Path $NeovimFolder)
    {
        Write-Host "Removing neovim configuration folder" -ForegroundColor "Cyan";
        Remove-Item -R $NeovimFolder
    }

    Copy-Item -R $DotfilesNeovimFolder $NeovimFolder
}

Set-Neovim-Configuration;

Write-Host "Finished neovim configuration." -ForegroundColor "Green";
