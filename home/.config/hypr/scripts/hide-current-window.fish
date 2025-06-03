#!/usr/bin/env fish

set target_workspace "special:hidden"
set active_address (hyprctl activewindow -j | jq -r .address)

hyprctl dispatch focuswindow address:$active_address
hyprctl dispatch movetoworkspacesilent special:hidden
