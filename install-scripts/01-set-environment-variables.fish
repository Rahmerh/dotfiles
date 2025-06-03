#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Setting environment variables"

set -Ux XDG_CONFIG_HOME ~/.config
set -Ux OBJC_DISABLE_INITIALIZE_FORK_SAFETY YES
set -Ux VISUAL nvim
set -Ux EDITOR nvim
set -Ux XCURSOR_THEME phinger-cursors
set -Ux STEAM_FRAME_FORCE_CLOSE 1
set -Ux BORG_REMOTE_PATH /usr/local/bin/borg

set -gx QT_QPA_PLATFORMTHEME qt5ct
set -gx QT_STYLE_OVERRIDE qt5ct
set -gx XDG_CURRENT_DESKTOP KDE

print_success "Done"
