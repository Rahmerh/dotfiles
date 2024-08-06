# Easy powershell editing
function Invoke-Edit-Powershell-Profile {
    nvim $PROFILE;
};
Set-Alias -Name profile -Value "Invoke-Edit-Powershell-Profile";

function Invoke-Refresh-Powershell-Profile {
    . $PROFILE;
};
Set-Alias -Name source -Value "Invoke-Refresh-Powershell-Profile";

# Default ls sucks
function Invoke-Better-Ls {
    lsd -lah
};
Set-Alias -Name ls -Value "Invoke-Better-Ls"

# Default cat sucks
Set-Alias -Name cat -Value bat

# Winget aliases
function Invoke-Winget-List {
    (winget list) -match ' winget$'
}
Set-Alias -Name wglist -Value "Invoke-Winget-List"

# I just want to pipe into grep
Set-Alias -Name grep -Value findstr

# Better pwd
function Invoke-Better-Pwd {
    (Get-Location | Select -ExpandProperty Path)
}
Set-Alias -Name pwd -Value "Invoke-Better-Pwd"

# Yazi alias
function yy {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

# Oh my posh
oh-my-posh init pwsh --config $PSScriptRoot\theme.json | Invoke-Expression

# Zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })
