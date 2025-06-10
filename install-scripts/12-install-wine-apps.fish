#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

function install_wine_app \
    --description "Install a Wine app in an isolated prefix" \
    --argument-names app_name github_repo winetricks_packages exe_relative_path

    set prefix_path ~/.local/wineprefixes/$app_name
    set exe_path "$prefix_path/$app_name-installer.exe"

    print_info "Installing '$app_name' to '$prefix_path'"

    set exe_urls (curl -s "https://api.github.com/repos/$github_repo/releases/latest" \
        | jq -r '.assets[] | select(.name | endswith(".exe")) | "\(.name)|\(.browser_download_url)"')

    if test (count $exe_urls) -eq 0
        print_error "No .exe assets found in $github_repo release"
        return 1
    end

    if test (count $exe_urls) -eq 1
        set selected_entry $exe_urls[1]
    else
        print_error "Multiple exes found, implement logic for this. Exiting"
        return 1
    end

    set selected_name (string split "|" $selected_entry)[1]
    set selected_url (string split "|" $selected_entry)[2]

    if not test -d $prefix_path
        mkdir -p $prefix_path

        gum spin --spinner dot --title "Booting Wine prefix..." -- \
            bash -c "WINEPREFIX='$prefix_path' wineboot -u > /dev/null 2>&1"
    end

    set winetricks_packages (string split ' ' -- $winetricks_packages)
    for pkg in $winetricks_packages
        gum spin --spinner dot --title "Installing package '$pkg'..." -- \
            bash -c "WINEPREFIX='$prefix_path' winetricks -q $pkg > /dev/null 2>&1"
    end

    if not test -e "$prefix_path/install-done"
        curl -L $selected_url -o $exe_path > /dev/null 2>&1
        WINEPREFIX=$prefix_path wine $exe_path > /dev/null 2>&1
        touch "$prefix_path/install-done"
    end

    print_success "Done"
end

install_wine_app \
    modorganizer \
    ModOrganizer2/modorganizer \
    "dotnet48 vcrun2019 corefonts" \
    "ModOrganizer2/ModOrganizer.exe"
