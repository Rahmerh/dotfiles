#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Installing/updating fisher"

if ! type -q fisher
    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher &> /dev/null
else
    fisher update jorgebucaran/fisher &> /dev/null
end

print_success "Done"

print_info "Installing fisher plugins"

print_info "Hydro prompt"
if ! test -e ~/.config/fish/conf.d/hydro.fish
    fisher install jorgebucaran/hydro &> /dev/null
else
    fisher update jorgebucaran/hydro &> /dev/null
end

print_info "Done notification"
if ! test -e ~/.config/fish/conf.d/done.fish
    fisher install franciscolourenco/done &> /dev/null
else
    fisher update franciscolourenco/done &> /dev/null
end

print_success "Done"
