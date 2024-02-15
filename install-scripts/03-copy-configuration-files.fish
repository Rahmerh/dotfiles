#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Copying all configuration files to correct folders"

sudo rsync -a "$PWD/etc/" "/etc"

print_success "Done"
