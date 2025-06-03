#!/usr/bin/env fish

set current_workspace (hyprctl activeworkspace -j | jq -r .name)

set selection (
  hyprctl clients -j | jq -r '.[] | select(.workspace.name == "special:hidden") | "\(.address) \(.title)"' \
  | rofi -dmenu -p "Restore window"
)

if test -z "$selection"
    exit
end

set address (echo $selection | awk '{print $1}')

hyprctl dispatch movetoworkspacesilent $current_workspace,address:$address
hyprctl dispatch focuswindow address:$address
