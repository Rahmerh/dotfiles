#!/usr/bin/env fish

set color "6b00f7"

razer-cli -e static --color "$color"
razer-cli --dpi 5000

openrgb -d 0 -m Direct -c "$color" -b 100 &> /dev/null
openrgb -d 1 -m Static -c "$color" -b 100 &> /dev/null
