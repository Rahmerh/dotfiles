#!/bin/bash

printf "This script will install and configure fish to be your default shell.\n"
printf "You will usually only execute this script once, once setup use apply.fish for applying your changes to your system.\n"

# Configuring/installing shell
printf "Installing fish.\n"

if ! command -v fish &> /dev/null
then
    pacman -S fish
else 
    printf "Fish already installed.\n"
fi

if [ "$SHELL" != "/usr/bin/fish" ]; then
    chsh -s /usr/bin/fish
else 
    printf "Shell already fish.\n"
fi

printf "\nExecuting apply script\n"

fish apply.fish
