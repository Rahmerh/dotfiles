Write-Host "Installing all applications." -ForegroundColor "Cyan";

winget install Neovim.Neovim
winget install JesseDuffield.lazygit
winget install JesseDuffield.lazydocker
winget install lsd
winget install Mozilla.Firefox
winget install fzf
winget install gokcehan.lf
winget install sharkdp.fd
winget install sharkdp.bat
winget install Microsoft.WindowsTerminal.Preview

# (winget list) -match ' winget$'
