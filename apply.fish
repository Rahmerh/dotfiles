#!/usr/bin/env fish

source install-scripts/library/print-utils.fish
source install-scripts/library/prompt-utils.fish

print_info "Hello $USER,"
print_info "This script will copy (and overwrite) to various folders on your system."
print_info "This script is designed to be executed over and over again, so no problem in running this multiple times."

for invalid in (find install-scripts -maxdepth 1 -name '*.fish' | grep -vE '/[0-9]{2}-[^/]+\.fish$')
    print_error "Invalid script name: $invalid. Must match NN-name.fish."
    exit 1
end

set scripts (find install-scripts -maxdepth 1 -name '*.fish' | sort)

set choices "Run all scripts (default)"
set -a choices $scripts

set choice (gum choose $choices)

if test -e "$choice"
    print_info "\nExecuting: $choice\n"
    fish $choice
    or begin
        print_error "Script $choice failed. Aborting."
        exit 1
    end
else
    for script in $scripts
        print_info "\nExecuting: $script\n"
        fish $script
        or begin
            print_error "Script $script failed. Aborting."
            exit 1
        end
    end
end
