#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Installing rofi calc"

yay --needed -S \
    rofi-calc \
    --noconfirm \
    > /dev/null 2>&1

print_success "Done"

print_info "Installing rofi power menu"

set ROFI_POWER_MENU_VERSION_FILE "/home/bas/.local/bin/rofi-power-menu-version.txt"

if ! test -e $ROFI_POWER_MENU_VERSION_FILE
    touch $ROFI_POWER_MENU_VERSION_FILE
end

set NEWEST_TAG (curl -s "https://api.github.com/repos/jluttine/rofi-power-menu/tags" | jq -r '.[0].name')
set CURRENTLY_INSTALLED (cat "$ROFI_POWER_MENU_VERSION_FILE")

if [ "$NEWEST_TAG" != "$CURRENTLY_INSTALLED" ]
    if test -d /tmp/rofi-power-menu
        sudo rm -rf /tmp/rofi-power-menu
    end

    print_info "Cloning powermenu repo & installing script ($NEWEST_TAG)."

    git clone git@github.com:jluttine/rofi-power-menu.git /tmp/rofi-power-menu &> /dev/null

    sudo cp -rf /tmp/rofi-power-menu/rofi-power-menu ~/.local/bin
    echo "$NEWEST_TAG" > "$ROFI_POWER_MENU_VERSION_FILE"
else 
    print_info "Latest powermenu already installed."
end

print_success "Done"
