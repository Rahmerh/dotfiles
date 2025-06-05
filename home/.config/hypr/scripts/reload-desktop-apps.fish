#!/usr/bin/env fish

hyprctl reload

pkill hyprpaper
hyprctl dispatch exec hyprpaper

pkill waybar
hyprctl dispatch exec waybar
