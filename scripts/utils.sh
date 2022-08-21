#!/bin/bash
print_in_color() {
    printf "%b" \
        "$(tput setaf "$2" 2> /dev/null)" \
        "$1" \
        "$(tput sgr0 2> /dev/null)"
}

print_error() {
    print_in_color "$1" 1
}

print_success() {
    print_in_color "$1" 2
}

print_warning() {
    print_in_color "$1" 3
}

print_info() {
    print_in_color "$1" 6
}
