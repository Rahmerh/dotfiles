#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Updating all packages and installing defaults"

if ! type -q yay
    bash -c 'rm -rf /tmp/yay ; mkdir -p /tmp/yay ; cd /tmp/yay ; wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz ; tar zxvf yay.tar.gz ; cd yay ; makepkg --syncdeps --rmdeps --install --noconfirm'
end

yay -Syu --noconfirm

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
    bitwarden \
    npm \
    steam \
    speedtest-cli \
    pacman-contrib \
    python-pip \
    ranger \
    python-pillow \
    python-pynvim \
    ueberzug \
    qutebrowser \
    i3 \
    dmenu \
    rofi \
    picom \
    ripgrep \
    polybar \
    zsa-keymapp-bin \
    notify-osd \
    ttf-jetbrains-mono \
    lightly-qt \
    qt5ct \
    kdialog \
    mpv \
    phinger-cursors \
    python-adblock \
    qt5-graphicaleffects \
    qt5-svg \
    qt5-quickcontrols2 \
    steam \
    gamemode \
    mcaselector \
    man \
    xorg-xwininfo \
    dxvk \
    vkd3d \
    mangohud \
    jq \
    glances \
    --noconfirm

if ! type -q cargo
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
end

print_info "Installing and updating cargo packages"

cargo install erdtree
cargo install systemctl-tui

print_success "Done"

print_info "Configuring and install misc tools"

if [ ! -L /usr/bin/systemctl-tui ]; then
    sudo ln -s ~/.cargo/bin/systemctl-tui /usr/bin/systemctl-tui
end

if ! type -q zoxide
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
end

if ! type -q mcfly
    sudo bash -c 'curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly'
end

print_success "Done"

sudo sh 'install-proton-ge'

print_success "Done"
