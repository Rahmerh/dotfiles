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

sudo cp /usr/share/sddm/themes/where_is_my_sddm_theme/example_configs/grey.conf /usr/share/sddm/themes/where_is_my_sddm_theme/theme.conf

print_success "Done"
