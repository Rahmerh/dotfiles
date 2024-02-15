#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

set DIR (dirname (cd (dirname (status -f)); and pwd)) 

print_info "Copy sddm config"

sudo cp "$DIR/etc/sddm.conf" /etc/sddm.conf

print_success "Done"

set SDDM_THEME_VERSION_FILE "/etc/sddm-version.txt"

if ! test -e $SDDM_THEME_VERSION_FILE
    sudo touch $SDDM_THEME_VERSION_FILE
end

print_info "Installing/updating catppuccin sddm theme"

set SDDM_NEWEST_COMMIT (git ls-remote git@github.com:catppuccin/sddm.git HEAD | awk '{ print $1}')
set SDDM_CURRENTLY_INSTALLED (cat "$SDDM_THEME_VERSION_FILE")

if [ "$SDDM_NEWEST_COMMIT" != "$SDDM_CURRENTLY_INSTALLED" ]
    if test -d /tmp/sddm-catppuccin-theme
        sudo rm -rf /tmp/sddm-catppuccin-theme
    end

    print_info "Cloning repo and installing theme ($SDDM_NEWEST_COMMIT)."

    git clone git@github.com:catppuccin/sddm.git /tmp/sddm-catppuccin-theme &> /dev/null

    sudo rm -rf /usr/share/sddm/themes/catppuccin-*
    sudo cp -rf /tmp/sddm-catppuccin-theme/src/* /usr/share/sddm/themes

    set SDDM_CURRENT_COMMIT (cd /tmp/sddm-catppuccin-theme && git rev-parse HEAD)
    sudo bash -c "echo \"$SDDM_CURRENT_COMMIT\" > \"$SDDM_THEME_VERSION_FILE\""
else 
    print_info "Latest catppuccin sddm theme already installed."
end

print_success "Done"

print_info "Copying wallpapers"

if test -d $HOME/Pictures/wallpapers
    rm -rf $HOME/Pictures/wallpapers
end

mkdir $HOME/Pictures/wallpapers

sudo cp $DIR/wallpapers/desktop-wallpaper.jpg $HOME/Pictures/wallpapers

print_success "Done"

print_info "Blurring wallpaper for login screen"

sudo convert $DIR/wallpapers/desktop-wallpaper.jpg -filter Gaussian -blur 0x8 /usr/share/sddm/themes/catppuccin-mocha/backgrounds/wall.jpg

print_success "Done"

print_info "Installing/updating catppuccin kitty theme"

set KITTY_THEME_VERSION_FILE "$HOME/.config/kitty/themes/catppuccin-mocha-version.txt"

if ! test -e $KITTY_THEME_VERSION_FILE
    sudo touch $KITTY_THEME_VERSION_FILE
end

set KITTY_NEWEST_COMMIT (git ls-remote git@github.com:catppuccin/kitty.git HEAD | awk '{ print $1}')
set KITTY_CURRENTLY_INSTALLED (cat "$KITTY_THEME_VERSION_FILE")

if [ "$KITTY_NEWEST_COMMIT" != "$KITTY_CURRENTLY_INSTALLED" ]
    if test -d /tmp/kitty-catppuccin-theme
        sudo rm -rf /tmp/kitty-catppuccin-theme
    end

    print_info "Cloning repo and installing theme ($KITTY_NEWEST_COMMIT)."

    git clone git@github.com:catppuccin/kitty.git /tmp/kitty-catppuccin-theme &> /dev/null

    cp -rf /tmp/kitty-catppuccin-theme/themes/*.conf ~/.config/kitty/themes

    set KITTY_CURRENT_COMMIT (cd /tmp/kitty-catppuccin-theme && git rev-parse HEAD)
    sudo bash -c "echo \"$KITTY_CURRENT_COMMIT\" > \"$KITTY_THEME_VERSION_FILE\""
else 
    print_info "Latest catppuccin kitty theme already installed."
end

print_success "Done"
