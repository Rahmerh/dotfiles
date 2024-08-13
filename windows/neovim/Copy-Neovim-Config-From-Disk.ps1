Write-Host "Copying neovim configuration to dotfiles folder." -ForegroundColor "Cyan";

rm -R "$HOME\\.dotfiles\\windows\\neovim\\nvim" -Force
cp -R "$env:LOCALAPPDATA\\nvim" "$HOME\\.dotfiles\\windows\\neovim\\"

Write-Host "Done." -ForegroundColor "Green";
