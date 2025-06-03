#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Copying all configuration files to correct folders"
# Copy other configuration files manually
print_success "Done"

print_info "Stow dotfiles"

stow home

print_success "Done"
