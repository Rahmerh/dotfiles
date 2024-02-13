#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Copy sddm config"

sudo cp "$PWD/etc/sddm.conf" /etc/sddm.conf

print_success "Done"

set SDDM_THEME_VERSION_FILE "/etc/sddm-version.txt"

if ! test -e $SDDM_THEME_VERSION_FILE
    sudo touch $SDDM_THEME_VERSION_FILE
end

print_info "Installing/updating catppuccin sddm theem"

set NEWEST_TAG (curl -s "https://api.github.com/repos/catppuccin/sddm/tags" | jq -r '.[0].name')
set CURRENTLY_INSTALLED (cat "$SDDM_THEME_VERSION_FILE")

if [ "$NEWEST_TAG" != "$CURRENTLY_INSTALLED" ]
    if test -d /tmp/sddm-catppuccin-theme
        sudo rm -rf /tmp/sddm-catppuccin-theme
    end

    print_info "Cloning repo and installing theme ($NEWEST_TAG)."

    git clone git@github.com:catppuccin/sddm.git /tmp/sddm-catppuccin-theme

    sudo rm -rf /usr/share/sddm/themes/catppuccin-mocha

    sudo cp -rf /tmp/sddm-catppuccin-theme/src/catppuccin-mocha /usr/share/sddm/themes
    sudo bash -c "echo \"$NEWEST_TAG\" > \"$SDDM_THEME_VERSION_FILE\""
else 
    print_info "Latest catppuccin sddm theme already installed."
end

print_success "Done"


# print_success "Done!\n"
#
# print_info "Copying wallpapers\n"
#
# if [ -d $HOME/Pictures/wallpapers ]; then
#     rm -rf $HOME/Pictures/wallpapers
# fi
#
# mkdir $HOME/Pictures/wallpapers
#
# sudo cp {{ .chezmoi.sourceDir }}/../wallpapers/desktop-wallpaper.jpg $HOME/Pictures/wallpapers
#
# sudo convert {{ .chezmoi.sourceDir }}/../wallpapers/desktop-wallpaper.jpg -filter Gaussian -blur 0x8 /usr/share/sddm/themes/catppuccin-frappe/backgrounds/wall.jpg
#
# print_success "Done!\n"
#
# print_info "Clone & install catppuccin kitty theme\n"
#
# if [ -d /tmp/kittycatppuccin ]; then
#     sudo rm -rf /tmp/kittycatppuccin
# fi
#
# git clone git@github.com:catppuccin/kitty.git /tmp/kittycatppuccin &> /dev/null
#
# cp -rf /tmp/kittycatppuccin/themes/mocha.conf ~/.config/kitty/themes
#
# print_success "Done!\n"
#
# {{- end }}
