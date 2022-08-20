#!/bin/bash
. "./scripts/utils.sh"
. "./scripts/kitty.sh"
. "./scripts/brew.sh"
. "./scripts/spotify.sh"
. "./scripts/slack.sh"

complete_setup=false
while getopts c flag
do
    case "${flag}" in
        c) echo "Got flag -e"
            complete_setup=true ;;
    esac
done

# Get sudo access
ask_for_sudo

# (Re)install brew
brew_setup

# (Re)create the .config folder
if [ ! -d ~/.config ]; then
    print_info "\nCreating config folder..\n"
    sudo mkdir ~/.config
    print_success "Done!\n"
else
    print_info "\nRecreating config folder..\n"
    sudo rm -rf ~/.config
    sudo mkdir ~/.config
    print_success "Done!\n"
fi

# Create symlinks for all dotfiles
print_info "\nCreating symlinks...\n"
create_symlink "$PWD/config/fish" ~/.config "fish"
create_symlink "$PWD/config/nvim" ~/.config "nvim"
create_symlink "$PWD/config/kitty" ~/.config "kitty"
create_symlink "$PWD/config/spotify-tui" ~/.config "spotify-tui"
create_symlink "$PWD/config/slack-term" ~/.config "slack-term"
print_success "\nDone!\n"

# Install brew packages
brew_bundle

kitty_replace_icon

change_wallpaper "$PWD/util/wallpapers/mountains.jpg"

# Setup applications.
if $complete_setup; then
    spotify_setup

    slack_setup
fi

print_success "\n\nDone setting up your system.\n\n"

finished_message=$(< ./util/ascii-art.txt)

print_success "$finished_message"
