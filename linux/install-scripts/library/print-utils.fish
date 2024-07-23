#!/usr/bin/env fish

set -U COLOR_RESET "\033[0m"

set -U COLOR_INFO "\033[0;36m" # Cyan
set -U COLOR_WARNING "\033[0;33m" # Yellow
set -U COLOR_ERROR "\033[0;33m" # Red
set -U COLOR_SUCCESS "\033[0;33m" # Green
set -U COLOR_MESSAGE "\033[0;33m" # White

function print_in_color -d="Print text in color"
    printf "%b" "$argv[1]$argv[2]$COLOR_RESET\n"
end

function print_error
    print_in_color $COLOR_ERROR "$argv[1]"
end

function print_success
    print_in_color $COLOR_SUCCESS "$argv[1]"
end

function print_warning
    print_in_color $COLOR_WARNING "$argv[1]"
end

function print_info 
    print_in_color $COLOR_INFO "$argv[1]"
end

function print_text 
    print_in_color $COLOR_MESSAGE "$argv[1]"
end
