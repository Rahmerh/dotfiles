#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Installing yazi plugins"

ya pkg add yazi-rs/plugins:no-status
ya pkg add yazi-rs/plugins:smart-enter
ya pkg add yazi-rs/plugins:git

print_success "Done"
