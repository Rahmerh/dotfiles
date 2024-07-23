#!/usr/bin/env fish

source install-scripts/library/print-utils.fish
source install-scripts/library/prompt-utils.fish

print_info "Hello $USER,"
print_info "This script will copy (and overwrite) to various folders on your system."
print_info "This script is designed to be executed over and over again, so no problem in running this multiple times."

if ! read_confirm "Continue?"
    print_info "Have a nice day!"
    exit 0
end

for script in install-scripts/*.fish
    print_info "\nExecuting: $script\n"
    fish $script "$SCRIPT_DIR"
end
