$DotfilesFolder = Join-Path -Path $HOME -ChildPath ".dotfiles";

# Run scripts
Invoke-Expression (Join-Path -Path $DotfilesFolder -ChildPath "windows" | Join-Path -ChildPath "windows-config" | Join-Path -ChildPath "Windows-Setup.ps1");
