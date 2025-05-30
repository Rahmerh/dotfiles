#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Setting kitty theme"

if ! test -d ~/dotfiles/home/.config/kitty/themes/kitty-themes
    git clone --depth 1 https://github.com/dexpota/kitty-themes.git ~/dotfiles/home/.config/kitty/themes/kitty-themes &> /dev/null
else
    cd ~/dotfiles/home/.config/kitty/themes/kitty-themes
    git pull &> /dev/null
end

cp ~/dotfiles/home/.config/kitty/themes/kitty-themes/themes/Chalk.conf ~/dotfiles/home/.config/kitty/themes/theme.conf

print_success "Done"

print_info "Setting sddm theme"

if ! test -d /tmp/sddm-theme 
    git clone git@github.com:stepanzubkov/where-is-my-sddm-theme.git /tmp/sddm-theme &> /dev/null
else
    cd /tmp/sddm-theme 
    git pull &> /dev/null
end

sudo /tmp/sddm-theme/install.sh current &> /dev/null

print_success "Done"

print_info "Setting firefox theme"

if ! test -d /tmp/firefox-theme 
    git clone git@github.com:cascadefox/cascade.git /tmp/firefox-theme &> /dev/null
else
    cd /tmp/firefox-theme
    git pull &> /dev/null
end

cd ~/.mozilla/firefox/*.default-release

set legacyStyleSheets $(cat prefs.js | grep legacy)

if ! test -n "$legacyStyleSheets"
    echo "user_pref(\"toolkit.legacyUserProfileCustomizations.stylesheets\", true);" >> prefs.js
end

cp -r /tmp/firefox-theme/chrome .

print_success "Done"

print_info "Setting wallpaper"

set expected "file://$HOME/Pictures/solid_wallpaper.png"
set statefile "$HOME/.cache/current_wallpaper.txt"

if test -e $statefile
    set current (cat $statefile)
else
    set current ""
end

if test "$current" != "$expected"
    magick -size 1x1 canvas:"#2c2c2c" "$HOME/Pictures/solid_wallpaper.png"

    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "
    var allDesktops = desktops();
    for (var i = 0; i < allDesktops.length; i++) {
        var d = allDesktops[i];
        d.wallpaperPlugin = 'org.kde.image';
        d.currentConfigGroup = ['Wallpaper', 'org.kde.image', 'General'];
        d.writeConfig('Image', 'file://$HOME/Pictures/solid_wallpaper.png');
    }" &> /dev/null

    kquitapp5 plasmashell
    sleep 1
    kstart5 plasmashell

    echo $expected > $statefile
end

print_success "Done"

print_info "Removing default task bar"

if ! test -e ~/dotfiles/config-backups/plasma-org.kde.plasma.desktop-appletsrc
    cp ~/.config/plasma-org.kde.plasma.desktop-appletsrc ~/dotfiles/config-backups/
end

sed -i '/\[Containments\]\[[0-9]*\]/,/^\[/ {/plugin=org.kde.panel/d}' ~/.config/plasma-org.kde.plasma.desktop-appletsrc
sed -i '/org.kde.plasma.panel/d' ~/.config/plasmashellrc

print_success "Done"
