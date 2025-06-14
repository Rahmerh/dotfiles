#!/bin/bash

declare -A known_sinks
known_sinks["AudioRelay-Virtual-Speaker"]="Audiorelay"
known_sinks["Built-in Audio Analog Stereo"]="Speakers"

active_sink=$(pactl list sinks | awk '$1 == "State:" && $2 == "RUNNING" { in_running_sink = 1 } in_running_sink && $1 == "Description:" { print substr($0, index($0,$2)); exit } ')

if [[ -n "${known_sinks[$active_sink]}" ]]; then
    echo "${known_sinks[$active_sink]}"
else
    echo "$active_sink"
fi
