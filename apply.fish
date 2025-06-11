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

set full_scripts (find install-scripts -type f -name '*.fish' | grep -v "/library/" | sort -V)

set scripts
for script in $full_scripts
    set stripped (string replace 'install-scripts/' '' $script)
    set -a scripts $stripped
end

set choices "Run all scripts (default)"
set -a choices $scripts

set selected (gum choose --no-limit --height 100 $choices)

function run_script
    set full_path install-scripts/$argv[1]
    print_info "\nExecuting: $argv[1]\n"
    fish $full_path
    or begin
        print_error "Script $argv[1] failed. Aborting."
        exit 1
    end
end

if test -z "$selected" || contains -- "Run all scripts (default)" $selected
    for script in $scripts
        run_script "$script"
    end
else
    for script in $selected
        run_script "$script"
    end
end
