#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Adding user to required groups"

if not groups $USER | grep -qw plugdev
    sudo gpasswd -a $USER plugdev
end

if not groups $USER | grep -qw vboxusers
    sudo gpasswd -a $USER vboxusers
end

print_success Done
