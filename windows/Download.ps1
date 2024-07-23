$GitHubRepositoryUri = "https://github.com/Rahmerh/dotfiles";

$DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles";
$DotfilesWorkFolder = Join-Path -Path $DotfilesFolder -ChildPath "windows";

if (Test-Path (Join-Path -Path $DotfilesFolder -ChildPath ".git"))
{
    Set-Location $DotfilesFolder
    git pull
    Write-Warning("Repository already cloned, you can run 'Apply.ps1' directly.")
} else
{
    git clone $GitHubRepositoryUri $DotfilesFolder
}

Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "Apply.ps1");
