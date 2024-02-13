#!/usr/bin/env fish

source install-scripts/library/print-utils.fish
source install-scripts/library/prompt-utils.fish

print_info "Hello $USER,"
print_info "This script will copy (and overwrite) to various folders on your system."
print_info "This script is designed to be executed over and over again, so no problem in running this multiple times."

if ! read_confirm "Continue?"
end

# # Configuring/installing shell
# print_info "Installing fish."
# if ! command -v fish &> /dev/null
# then
#     pacman -S fish
# else 
#     print_info "Fish already installed."
# fi
#
# if [ "$SHELL" != "/usr/bin/fish" ]; then
#     chsh -s /usr/bin/fish
# else 
#     print_info "Shell already fish."
# fi
#

for script in install-scripts/*.fish
    print_info "\nExecuting: $script\n"
    fish $script "$SCRIPT_DIR"
end
