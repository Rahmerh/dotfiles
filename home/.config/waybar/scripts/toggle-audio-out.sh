#!/bin/bash

audiorelay="audiorelay-out"
speakers="alsa_output.pci-0000_00_1f.3.analog-stereo"

current_sink=$(pactl get-default-sink)

if [[ "$current_sink" == "$audiorelay" ]]; then
    pactl set-default-sink "$speakers"
elif [[ "$current_sink" == "$speakers" ]]; then
    pactl set-default-sink "$audiorelay"
fi

