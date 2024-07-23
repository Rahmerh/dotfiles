Write-Host "Installing all applications." -ForegroundColor "Cyan";

winget install Neovim.Neovim
winget install JesseDuffield.lazygit
winget install JesseDuffield.lazydocker
winget install lsd
winget install Mozilla.Firefox

# (winget list) -match ' winget$'
