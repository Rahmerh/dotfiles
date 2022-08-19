#!/bin/bash
. "$PWD/util/utils.sh"

printf "\nChecking for sudo access...\n\n"

ask_for_sudo

printf "\nInstalling brew...\n\n"

sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
eval "$(/opt/homebrew/bin/brew shellenv)"

if [ ! -d ~/.config ]; then
	printf "\nCreating config folder.."
	sudo mkdir ~/.config
else
	printf "\nRecreating config folder.."
    sudo rm -rf ~/.config
	sudo mkdir ~/.config
fi

# Set fish config before doing anything else
# This is needed for brew to work
sudo ln -s "$PWD/.config/fish" ~/.config

printf "\nInstalling packages...\n\n"

brew install kitty
brew install --HEAD neovim
brew install fish
brew install spotify-tui

if [ "$SHELL" != "/opt/homebrew/bin/fish" ]; then
    printf "\nSetting fish as your default shell\n\n"

    sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
	chsh -s /opt/homebrew/bin/fish
fi

printf "\nCreating symlinks...\n\n"

sudo ln -s "$PWD/.config/nvim" ~/.config

if [ -d ~/.config/kitty ]; then 
    rm -rf ~/.config/kitty
fi

sudo ln -s "$PWD/.config/kitty" ~/.config
