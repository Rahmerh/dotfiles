$GitHubRepositoryUri = "https://github.com/Rahmerh/dotfiles";

$DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles";
$DotfilesWorkFolder = Join-Path -Path $DotfilesFolder -ChildPath "windows";

if (Test-Path $DotfilesFolder)
{
    Remove-Item -Path $DotfilesFolder -Recurse -Force;
}
New-Item $DotfilesFolder -ItemType directory;

git clone $GitHubRepositoryUri $DotfilesFolder

Invoke-Expression (Join-Path -Path $DotfilesWorkFolder -ChildPath "Apply.ps1");
