#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Configuring librewolf"

set profile_dir (find ~/.librewolf -maxdepth 1 -type d -name "*.default-default" | head -n 1)
set prefs "$profile_dir/prefs.js"

function set_pref --argument key value
    sed -i "/user_pref(\"$key\"/d" $prefs
    echo "user_pref(\"$key\", $value);" >> $prefs
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

print_success "Done"

print_info "Configuring surf"

set blocklist_url "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"
set target_file ~/.config/surf/adblock

mkdir -p ~/.config/surf

# curl -s $blocklist_url | \
#     grep -Eo "^\|\|[^\/^\*]*" | \
#     sed 's/||//' | \
#     sort -u > $target_file

print_success "Done"
