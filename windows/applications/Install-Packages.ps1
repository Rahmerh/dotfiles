function Configure-Autostart-For-App {
    [CmdletBinding()]
    param (
        [Parameter( Position = 0, Mandatory = $TRUE)]
        [String]
        $AppName,
        [Parameter( Position = 1, Mandatory = $TRUE)]
        [String]
        $ExecutableName
    )

    $TargetFile =  "$HOME\scoop\apps\$AppName\current\$ExecutableName.exe"
    $ShortcutFile = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\$AppName.lnk"
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
    $Shortcut.TargetPath = $TargetFile
    $Shortcut.Save()

    Write-Host "Configured autostart for $AppName" -ForegroundColor "Green";
}

Write-Host "Installing all applications." -ForegroundColor "Cyan";

# Buckets
scoop bucket add extras
scoop bucket add java
scoop bucket add nerd-fonts
scoop bucket add games
scoop bucket add versions
scoop bucket add nonportable

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
scoop install ripgrep

# Misc
scoop install firefox
scoop install zig
scoop install 7zip
scoop install wireguard-np
scoop install jq poppler imagemagick

# Code development
scoop install docker
scoop install nodejs
scoop install openjdk21
scoop install git 
scoop install aws
scoop install granted 

# Terminal
scoop install pwsh
scoop install windows-terminal-preview

# Fonts
scoop install nerd-fonts/JetBrainsMono-NF-Mono

# Socials
scoop install steam
scoop install discord
scoop install slack

# Don't need this
winget uninstall Microsoft.WindowsTerminal
winget uninstall Microsoft.Edge
winget uninstall Microsoft.OneDrive

# Set autostart for apps
Configure-Autostart-For-App -AppName slack -ExecutableName slack
Configure-Autostart-For-App -AppName discord -ExecutableName discord-portable
Configure-Autostart-For-App -AppName steam -ExecutableName steam
