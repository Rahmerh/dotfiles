#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Configuring librewolf"

set profile_dir (find ~/.librewolf -maxdepth 1 -type d -name "*.default-default" | head -n 1)
set prefs "$profile_dir/prefs.js"

function set_pref --argument key value
    sed -i "/user_pref(\"$key\"/d" $prefs
    echo "user_pref(\"$key\", $value);" >> $prefs
end

function install_extension --argument extension_name
    set tmpfile /tmp/temp.xpi
    set profile_dir (find ~/.librewolf -maxdepth 2 -type d -name '*.default*' | head -n 1)
    set extensions_dir "$profile_dir/extensions"
    set cache_file "$extensions_dir/installed-extensions-cache.json"

    if not test -d $extensions_dir
        mkdir -p $extensions_dir
    end

    if ! test -e $cache_file
        echo "{}" > $cache_file
    end

    set ext_id (jq -r --arg slug "$extension_name" '.[$slug] // empty' $cache_file)
    if test -n "$ext_id" -a -e "$extensions_dir/$ext_id.xpi"
        print_info "Extension $extension_name already installed as $ext_id, skipping"
        return 0
    end

    curl -Lo $tmpfile "https://addons.mozilla.org/firefox/downloads/latest/$extension_name/latest.xpi" &> /dev/null

    set ext_id (unzip -p $tmpfile manifest.json | jq -r '.browser_specific_settings.gecko.id')

    if test -z "$ext_id"
        print_error "Failed to extract extension ID, exiting"
        return 1
    end

    # Append slug → ID mapping to cache
    jq --arg slug "$extension_name" --arg id "$ext_id" '. + {($slug): $id}' $cache_file > /tmp/new-cache.json
    mv /tmp/new-cache.json $cache_file

    cp $tmpfile "$profile_dir/extensions/$ext_id.xpi"

    print_success "Succesfully installed $extension_name. Restart librewolf and enable it manually."
end

set_pref "privacy.clearOnShutdown.cookies" false
set_pref "privacy.clearOnShutdown.history" true
set_pref "privacy.clearOnShutdown.sessions" false
set_pref "privacy.clearOnShutdown.cache" true
set_pref "privacy.clearOnShutdown.offlineApps" true
set_pref "privacy.clearOnShutdown.siteSettings" false
set_pref "network.cookie.lifetimePolicy" 0
set_pref "browser.sessionstore.resume_from_crash" false
set_pref "toolkit.legacyUserProfileCustomizations.stylesheets" true

install_extension "ghostery"
install_extension "sponsorblock"
install_extension "darkreader"
install_extension "passff"
install_extension "adaptive-tab-bar-colour"

print_success "Done"
