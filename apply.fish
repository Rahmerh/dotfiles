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

for invalid in (find install-scripts -maxdepth 1 -name '*.fish' | grep -vE '/[0-9]{2}-[^/]+\.fish$')
    print_error "Invalid script name: $invalid. Must match NN-name.fish."
    exit 1
end

set scripts (find install-scripts -maxdepth 1 -name '*.fish' | sort)

print_info "Available scripts:"
for i in (seq (count $scripts))
    set script $scripts[$i]
    set script_id (string match -r '[0-9]{2}' $script)
    print_text "  $script_id $script"
end

print_info "Enter script number (or leave empty to run all): "
read script_num

if test -n "$script_num"
    set match
    for s in $scripts
        set padded_num (printf "%02d" $script_num)
        if string match -rq ".*/($script_num|$padded_num)-[^/]*\.fish" -- $s
            set match $s
            break
        end
    end

    if test (count $match) -eq 1
        set scripts $match
    else
        print_error "Script $script_num not found."
        exit 1
    end
end

for script in $scripts
    print_info "\nExecuting: $script\n"
    fish $script
    or begin
        print_error "Script $script failed. Aborting."
        exit 1
    end
end
