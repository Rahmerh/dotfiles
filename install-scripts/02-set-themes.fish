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

print_info "Setting librewolf theme"

if ! test -d /tmp/librewolf-theme 
    git clone git@github.com:cascadefox/cascade.git /tmp/librewolf-theme &> /dev/null
else
    cd /tmp/librewolf-theme/
    git pull &> /dev/null
end

cd ~/.librewolf/*.default-default

cp -r /tmp/librewolf-theme/chrome .

print_success "Done"

print_info "Creating wallpaper"

set expected "$HOME/Pictures/solid_wallpaper.png"
if ! test -e $expected
    magick -size 5120x1440 canvas:"#2c2c2c" "$expected"
end

print_success "Done"

print_info "Removing default task bar"

if ! test -e ~/dotfiles/config-backups/plasma-org.kde.plasma.desktop-appletsrc
    cp ~/.config/plasma-org.kde.plasma.desktop-appletsrc ~/dotfiles/config-backups/
end

sed -i '/\[Containments\]\[[0-9]*\]/,/^\[/ {/plugin=org.kde.panel/d}' ~/.config/plasma-org.kde.plasma.desktop-appletsrc
sed -i '/org.kde.plasma.panel/d' ~/.config/plasmashellrc

print_success "Done"
