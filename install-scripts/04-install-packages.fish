#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Updating all packages and installing defaults"

if ! type -q yay
    bash -c 'rm -rf /tmp/yay ; mkdir -p /tmp/yay ; cd /tmp/yay ; wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz ; tar zxvf yay.tar.gz ; cd yay ; makepkg --syncdeps --rmdeps --install --noconfirm'
end

yay --needed -S \
    neovim \
    fish \
    kitty \
    lsd \
    bat \
    xclip \
    mc \
    firewalld \
    solaar \
    lazygit \
    pulsemixer \
    steam \
    ranger \
    ueberzug \
    firefox \
    dmenu \
    albert \
    ripgrep \
    zsa-keymapp-bin \
    ttf-jetbrains-mono-nerd \
    gamemode \
    jq \
    stow \
    neofetch \
    qt5-tools \
    fish-lsp \
    discord \
    waybar \
    hyprland \
    hyprpaper \
    xdg-desktop-portal-hyprland \
    wl-clipboard \
    grim \
    slurp \
    --noconfirm

print_info "Configuring and install misc tools"

if ! type -q zoxide
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
end

if ! type -q mcfly
    sudo bash -c 'curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly'
end

print_success "Done"
