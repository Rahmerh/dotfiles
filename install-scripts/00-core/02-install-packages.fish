#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Updating all packages and installing defaults"

if not type -q yay
    set yay_dir (mktemp -d -t yay-XXXX)
    cd $yay_dir
    wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz
    tar zxvf yay.tar.gz
    cd yay
    makepkg --syncdeps --rmdeps --install --noconfirm
end

yay -S --repo=extra python-markupsafe --noconfirm

# Core CLI tools
set core_packages \
    neovim \
    fish \
    kitty \
    bat \
    lsd \
    ripgrep \
    jq \
    stow \
    pv \
    pass \
    gnupg \
    passff-host \
    tealdeer \
    neofetch

# GUI/system tools
set gui_packages \
    librewolf \
    steam \
    firewalld \
    lazygit \
    pulsemixer \
    audiorelay \
    discord \
    borg \
    gamemode

# Hyprland stack
set hyprland_packages \
    hyprland \
    hyprpaper \
    hyprpicker \
    waybar \
    mako \
    grim \
    slurp \
    wl-clipboard \
    xdg-desktop-portal-hyprland

# Fonts
set font_packages \
    ttf-jetbrains-mono-nerd \
    ttf-inter

# Dev tools
set dev_packages \
    dotnet-sdk \
    fish-lsp \
    npm \
    qt5-tools \
    openrazer-meta \
    razer-cli \
    zsa-keymapp-bin

yay --needed -S \
    $core_packages \
    $gui_packages \
    $hyprland_packages \
    $font_packages \
    $dev_packages \
    --noconfirm

print_info "Configuring and install misc tools"

if ! type -q zoxide
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
end

if ! type -q mcfly
    sudo bash -c 'curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly'
end

if ! type -q rustc
    curl https://sh.rustup.rs -sSf | sh -s -- -y
end

print_success Done
