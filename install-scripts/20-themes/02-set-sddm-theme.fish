#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

set theme_repo ~/repos/sddm-theme

print_info "Setting sddm theme"

if not test -d "$theme_repo"
    print_info "Cloning theme repo"
    command git clone https://github.com/stepanzubkov/where-is-my-sddm-theme.git "$theme_repo" &>/dev/null
else
    print_info "Updating theme repo"
    command git -C "$theme_repo" pull &>/dev/null
end

sudo "$theme_repo/sddm-theme/install.sh" current &>/dev/null

print_success Done
