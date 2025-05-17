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
