#!/usr/bin/env fish
source install-scripts/library/download-utils.fish
source install-scripts/library/print-utils.fish

print_info "Downloading icons"

set -l icon_dir ~/.local/share/icons

download_favicon nexusmods.com /tmp/nexusmods.ico

magick /tmp/nexusmods.ico "$icon_dir/nexusmods.png"

print_success Done
