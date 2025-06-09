#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Setting rofi-pass script exec path"

set desktop_file "$HOME/.local/share/applications/rofi-pass.desktop"

sed -i "s;^Exec=.*;Exec=$HOME/.config/rofi/scripts/launch-rofi-pass.sh;" $desktop_file

print_success "Done"
