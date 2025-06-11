#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

function install_wine_app \
    --description "Install a Wine app in an isolated prefix" \
    --argument-names app_name github_repo winetricks_packages exe_relative_path

    for cmd in wine winetricks jq curl
        if not type -q $cmd
            print_error "$cmd is not installed"
            return 1
        end
    end

    set prefix_path "$HOME/.local/wineprefixes/$app_name"
    set exe_path "$prefix_path/$app_name-installer.exe"

    print_info "Installing '$app_name' to '$prefix_path'"

    set exe_urls ( curl -s "https://api.github.com/repos/$github_repo/releases/latest" \
        |  jq -r '.assets[] | select(.name | endswith(".exe")) | "\(.name)|\(.browser_download_url)"')

    if test (count $exe_urls) -eq 0
        print_error "No .exe assets found in $github_repo release"
        return 1
    end

    if test (count $exe_urls) -eq 1
        set selected_entry $exe_urls[1]
    else
        print_error "Multiple .exe files found in $github_repo release:"
        for entry in $exe_urls
            print_error "  - $entry"
        end
        print_error "Update script to handle multiple installers."
        return 1
    end

    set selected_name (string split "|" $selected_entry)[1]
    set selected_url (string split "|" $selected_entry)[2]

    if not test -d "$prefix_path"
        mkdir -p "$prefix_path"
        gum spin --spinner dot --title "Booting wine prefix..." -- \
            bash -c "WINEPREFIX='$prefix_path' wineboot -u > /dev/null 2>&1"
    end

    set cache_root ~/.local/wineprefixes/.cache
    for pkg in (string split ' ' -- "$winetricks_packages")
        set pkg_cache "$cache_root/$pkg"

        if not test -d "$pkg_cache"
            print_info "Caching winetricks package '$pkg'"

            set tmp_prefix (mktemp -d ~/.cache/tmp-wine-prefix-XXXXXX)

            gum spin --spinner dot --title "Booting temp wine prefix..." -- \
                bash -c "WINEPREFIX=$tmp_prefix wineboot -u &>/dev/null"

            gum spin --spinner dot --title "Installing '$pkg' into temp folder..." -- \
                bash -c "WINEPREFIX=$tmp_prefix winetricks -q $pkg &>/dev/null"

            if test $status -ne 0
                print_error "Failed to install '$pkg' to cache"
                rm -rf $tmp_prefix
                return 1
            end

            mkdir -p "$cache_root"
            mv "$tmp_prefix" "$pkg_cache"
        end

        cp -a "$pkg_cache/." "$prefix_path/"

        gum spin --spinner dot --title "Registering '$pkg' in real prefix..." -- \
            bash -c "WINEPREFIX=$prefix_path winetricks -q $pkg &>/dev/null"
        if test $status -ne 0
            print_error "Failed to install '$pkg' with winetricks"
            return 1
        end
    end

    if not test -e "$prefix_path/install-done"
        curl -L "$selected_url" -o "$exe_path" >/dev/null 2>&1
        if not test -f "$exe_path"
            print_error "Failed to download $selected_name"
            return 1
        end

        gum spin --spinner dot --title "Running installer at '$exe_path'..." -- \
            bash -c "WINEPREFIX=$prefix_path wine $exe_path &>/dev/null"
        if test $status -ne 0
            print_error "Installer for $app_name failed"
            return 1
        end

        touch "$prefix_path/install-done"
    end

    print_success Done
end

install_wine_app \
    modorganizer \
    ModOrganizer2/modorganizer \
    "dotnet48 vcrun2019 corefonts" \
    "ModOrganizer2/ModOrganizer.exe"
