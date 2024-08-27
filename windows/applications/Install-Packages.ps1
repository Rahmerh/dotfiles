function Configure-Autostart-For-App
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

function Download-Latest-Github-Release
{
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
        $AssetName,
        [Parameter( Position = 3, Mandatory = $FALSE)]
        [String]
        $Version
    )
    $versionToGet = "latest"
    if($Version -ne "")
    {
        $versionToGet = $Version
    }

    $json = Invoke-Webrequest -Uri "https://api.github.com/repos/$RepositoryName/releases/$versionToGet"

    $release = $json.Content | ConvertFrom-Json

    $release.assets | Where-Object{$_.name -like $AssetName } | ForEach-Object{
        $asset = $_;

        $ArchiveName = $asset.name

        Invoke-Webrequest -Uri $($asset.url) -OutFile "$TargetDir\$($asset.name)" -Headers @{'Accept'='application/octet-stream'}

        $DestinationPath = "$TargetDir\$($RepositoryName.Split('/')[1])"

        if(Test-Path -Path $DestinationPath)
        {
            Remove-Item -Recurse $DestinationPath -Force
        }

        if([IO.Path]::GetExtension($ArchiveName) -eq ".zip")
        {
            Expand-Archive -Path "$TargetDir\\$ArchiveName" -DestinationPath $DestinationPath
            Remove-Item "$TargetDir\\$ArchiveName" -Force

            Write-Host "Expanded zip to $DestinationPath"

            $binFolder = Get-ChildItem -Path $DestinationPath -Filter "bin" -Directory -Recurse

            $binFolderInPath = $env:PATH -split ";" | Where-Object { $_ -like $binFolder }

            Write-Host $binFolderInPath

            if($binFolderInPath -eq "")
            {
                # $CurrentPATH = ([Environment]::GetEnvironmentVariable("PATH")).Split(";")
                # $NewPATH = ($CurrentPATH + $BinFolder) -Join ";"
                # [Environment]::SetEnvironmentVariable("PATH", $NewPath, [EnvironmentVariableTarget]::Machine) 
                Write-Host "Appending bin folder to PATH"
            } else
            {
                Write-Host "Not appending bin folder to PATH"
            }
        } else
        {
            Write-Host "It's not a zip!"
        }
    }
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
scoop install ripgrep
scoop install spotify-tui

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

# Install packages that aren't available on scoop
winget install Microsoft.Teams
go install github.com/jorgerojas26/lazysql@latest

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
Download-Latest-Github-Release -RepositoryName pmd/pmd -TargetDir C:\tools -AssetName "pmd-dist-*-bin.zip" -Version "6.55.0"
Download-Latest-Github-Release -RepositoryName checkstyle/checkstyle -TargetDir C:\tools -AssetName "checkstyle-*-all.jar"
