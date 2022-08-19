#!/bin/bash
. "$PWD/util/utils.sh"

print_in_yellow "\nChecking for sudo access...\n"
ask_for_sudo
print_in_green "Done!\n"


print_in_yellow "\n(Re)installing brew...\n"
echo | sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash > /dev/null
eval "$(/opt/homebrew/bin/brew shellenv)"
print_in_green "Done!\n"

if [ ! -d ~/.config ]; then
	print_in_yellow "\nCreating config folder..\n"
	sudo mkdir ~/.config
    print_in_green "Done!\n"
else
	printf "\nRecreating config folder..\n"
    sudo rm -rf ~/.config
	sudo mkdir ~/.config
    print_in_green "Done!\n"
fi

# Set fish config before doing anything else
# This is needed for brew to work
sudo ln -s "$PWD/.config/fish" ~/.config

print_in_yellow "\nInstalling packages...\n\n"

install_package "kitty"
install_package "--HEAD neovim"
install_package "fish"
install_package "spotify-tui"

if [ "$SHELL" != "/opt/homebrew/bin/fish" ]; then
    print_in_yellow "\nSetting fish as your default shell\n\n"

    sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
	chsh -s /opt/homebrew/bin/fish
fi

print_in_yellow "\nCreating symlinks...\n"

sudo ln -s "$PWD/.config/nvim" ~/.config
if [ -d ~/.config/kitty ]; then 
    rm -rf ~/.config/kitty
fi
sudo ln -s "$PWD/.config/kitty" ~/.config

print_in_green "Done!\n"
