function Configure-Autostart-For-App {
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

    if ($ExecutableName -eq $NULL){
        $ExecutableName = $AppName;
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

function Download-Latest-Github-Release {
    [CmdletBinding()]
    param (
        [Parameter( Position = 0, Mandatory = $TRUE)]
        [String]
        $RepositoryName,
        [Parameter( Position = 1, Mandatory = $TRUE)]
        [String]
        $TargetDir,
        [Parameter( Position = 2, Mandatory = $TRUE)]
        [String]
        $AssetName
    )
    $json = Invoke-Webrequest -Uri "https://api.github.com/repos/$RepositoryName/releases/latest"

    $release = $json.Content | ConvertFrom-Json

    $release.assets | Where-Object{$_.name -like $AssetName } | ForEach-Object{
        $asset = $_;

        $ArchiveName = $asset.name

        Invoke-Webrequest -Uri $($asset.url) -OutFile "$TargetDir\$($asset.name)" -Headers @{'Accept'='application/octet-stream'}

        $DestinationPath = "$TargetDir\\$($RepositoryName.Split('/')[1])"

        if(Test-Path -Path $DestinationPath){
            Remove-Item -Recurse $DestinationPath -Force
        }

        Expand-Archive -Path "$TargetDir\\$ArchiveName" -DestinationPath $DestinationPath

        Remove-Item "$TargetDir\\$ArchiveName" -Force
    }
}

function Search-And-Add-Bin-Folder-To-Path {
    [CmdletBinding()]
    param (
        [Parameter( Position = 0, Mandatory = $TRUE)]
        [String]
        $SourceFolder
    )
    $BinFolder = Get-ChildItem $SourceFolder "bin" -Recurse -Directory

    $CurrentPATH = ([Environment]::GetEnvironmentVariable("PATH")).Split(";")
    $NewPATH = ($CurrentPATH + $BinFolder) -Join ";"
    [Environment]::SetEnvironmentVariable("PATH", $NewPath, [EnvironmentVariableTarget]::Machine) 
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
scoop install jq

# Code development
scoop install docker-compose
scoop install nodejs
scoop install openjdk21
scoop install git 
scoop install aws
scoop install granted 
scoop install maven

# Terminal
scoop install pwsh
scoop install windows-terminal-preview

# Fonts
scoop install nerd-fonts/JetBrainsMono-NF-Mono

# Socials
scoop install steam
scoop install discord
scoop install slack
scoop install spotify

# Docker desktop isn't on scoop :(
# The docker package is only capable of running windows containers. That's why I'll have to get it via winget.
winget install Docker.DockerDesktop
winget install Microsoft.Teams

# Don't need this
winget uninstall Microsoft.WindowsTerminal
winget uninstall Microsoft.Edge
winget uninstall Microsoft.OneDrive

# Set autostart for apps
Configure-Autostart-For-App -AppName slack -Arguments "-u"
Configure-Autostart-For-App -AppName discord -ExecutableName discord-portable -Arguments "--start-minimized"
Configure-Autostart-For-App -AppName steam -Arguments "-nochatui -nofriendsui -silent"
Configure-Autostart-For-App -AppName spotify -Arguments "--minimized"

# Download binaries directly from github
Download-Latest-Github-Release -RepositoryName pmd/pmd -TargetDir C:\tools -AssetName "pmd-dist-*-bin.zip"
Search-And-Add-Bin-Folder-To-Path -SourceFolder C:\tools\pmd
