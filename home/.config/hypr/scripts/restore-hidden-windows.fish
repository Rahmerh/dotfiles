#!/usr/bin/env fish

set selection (
  hyprctl clients -j | jq -r '.[] | select(.workspace.name == "special:hidden") | "\(.address) \(.title)"' \
  | rofi -dmenu -p "Restore window"
)

if test -z "$selection"
    exit
end

set address (echo $selection | awk '{print $1}')

hyprctl dispatch movetoworkspacesilent (hyprctl activeworkspace -j | jq -r .name),address:$address
hyprctl dispatch focuswindow address:$address
