#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Copying all configuration files to correct folders"

sudo rsync -a "$PWD/etc/" "/etc" 

sudo rsync -a "$PWD/home/" $HOME 

print_success "Done"
