#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Installing/updating fisher"

if ! type -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher &> /dev/null
else
    fisher update jorgebucaran/fisher &> /dev/null
end

print_success "Done"
