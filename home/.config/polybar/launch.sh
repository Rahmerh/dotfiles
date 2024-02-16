#!/usr/bin/env bash

polybar-msg cmd quit

polybar left 2>&1 | tee -a /tmp/polybar1.log & disown
polybar right 2>&1 | tee -a /tmp/polybar2.log & disown
