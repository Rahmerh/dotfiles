#!/bin/bash

CONFIG="$HOME/.config/waybar/bars/audio-slider/config.jsonc"
STYLE="$HOME/.config/waybar/bars/audio-slider/style.css"

if pgrep -f "waybar.*$CONFIG" > /dev/null; then
    pkill -f "waybar.*$CONFIG"
else
    waybar -c "$CONFIG" -s "$STYLE" &
fi
