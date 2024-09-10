function Configure-Autostart-For-Scoop-App
{
    [CmdletBinding()]
    param (
        [Parameter( Position = 0, Mandatory = $TRUE)]
        [String]
        $AppName,
        [Parameter( Position = 1, Mandatory = $FALSE)]
        [String]
        $ExecutableName,
        [Parameter( Position = 2, Mandatory = $FALSE)]
        [String]
        $Arguments
    )

    if ($ExecutableName -eq "")
    {
        $ExecutableName = "$AppName";
    } 

    $TargetFile =  "$HOME\scoop\apps\$AppName\current\$ExecutableName.exe"
    $ShortcutFile = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\$AppName.lnk"
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
    $Shortcut.TargetPath = $TargetFile
    $Shortcut.Arguments = $Arguments
    $Shortcut.Save()

    Write-Host "Configured autostart for $AppName" -ForegroundColor "Green";
}

# Make sure chocolately is installed.
if(-not (Get-Command choco -ErrorAction SilentlyContinue))
{
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

# Make sure scoop is installed.
if(-not (Get-Command scoop -ErrorAction SilentlyContinue))
{
    irm get.scoop.sh | iex
}

Write-Host "Installing all applications." -ForegroundColor "Cyan";

# Buckets
scoop bucket add extras
scoop bucket add java
scoop bucket add nerd-fonts
scoop bucket add games
scoop bucket add versions
scoop bucket add nonportable
scoop bucket add scoop-bucket https://github.com/Rigellute/scoop-bucket

# Cli tools
scoop install yazi
scoop install lazygit
scoop install lazydocker
scoop install zoxide
scoop install neovim
scoop install oh-my-posh
scoop install fzf
scoop install lsd
scoop install bat
scoop install fd
scoop install sed
scoop install gawk
scoop install ripgrep
scoop install base64

# Misc
scoop install firefox
scoop install zig
scoop install 7zip
scoop install wireguard-np
scoop install jq
scoop install paint.net

# Code development
scoop install docker-compose
scoop install nodejs
scoop install openjdk21
scoop install git 
scoop install aws
scoop install granted 
scoop install maven
scoop install make
scoop install go
scoop install postman
scoop install act

# Terminal
scoop install pwsh
scoop install windows-terminal-preview

# Fonts
scoop install nerd-fonts/JetBrainsMono-NF-Mono

# Socials
scoop install steam
scoop install discord
scoop install slack

# Install packages that aren't available on scoop
winget install Microsoft.Teams
go install github.com/jorgerojas26/lazysql@latest
choco install pmd --version=6.55.0 -y

# Don't need this
winget uninstall Microsoft.WindowsTerminal
winget uninstall Microsoft.Edge
winget uninstall Microsoft.OneDrive

# Set autostart for apps
Configure-Autostart-For-Scoop-App -AppName slack -Arguments "-u"
Configure-Autostart-For-Scoop-App -AppName discord -ExecutableName discord-portable -Arguments "--start-minimized"
Configure-Autostart-For-Scoop-App -AppName steam -Arguments "-nochatui -nofriendsui -silent"
