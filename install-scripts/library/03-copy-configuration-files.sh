#!/bin/bash
# source $(dirname "$0")/library/print-utils.sh

print_info "Copying all configuration files to correct folders\n"

echo "$1/etc"

sudo cp -rf "$1/etc" "/"

echo "$1/etc"
