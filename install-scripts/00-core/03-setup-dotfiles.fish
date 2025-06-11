#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Stow dotfiles"

stow home

print_success Done
