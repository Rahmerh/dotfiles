#!/usr/bin/env fish
source install-scripts/library/print-utils.fish

print_info "Updating all packages and installing defaults"

if ! type -q yay
    bash -c 'rm -rf /tmp/yay ; mkdir -p /tmp/yay ; cd /tmp/yay ; wget https://aur.archlinux.org/cgit/aur.git/snapshot/yay.tar.gz ; tar zxvf yay.tar.gz ; cd yay ; makepkg --syncdeps --rmdeps --install --noconfirm'
end

yay -S --repo=extra python-markupsafe --noconfirm

yay --needed -S \
    neovim \
    fish \
    kitty \
    lsd \
    bat \
    firewalld \
    lazygit \
    pulsemixer \
    steam \
    ranger \
    librewolf \
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
    borg \
    systemctl-tui \
    pass \
    gnupg \
    passff-host \
    audiorelay \
    --noconfirm

# Needed for surf
yay --needed -S \
    gst-plugins-base \
    gst-plugins-good \
    gst-plugins-bad \
    gst-plugins-ugly \
    gst-libav \
    --noconfirm

print_info "Configuring and install misc tools"

if ! type -q zoxide
    curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
end

if ! type -q mcfly
    sudo bash -c 'curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sh -s -- --git cantino/mcfly'
end

if ! type -q surf
    set build_dir ~/builds/surf

    git clone https://git.suckless.org/surf $build_dir
    cd "$build_dir"

    print_info "What's the git remote of your fork?"
    set git_fork (gum input --placeholder "git@github.com:replace/this.git")

    git remote rename origin upstream
    git remote add origin $git_fork
    git push --mirror origin

    # Lock to the known-good commit for patch compatibility
    git checkout 5f940292

    sudo make clean install > /tmp/surf_build.log 2>&1

    if test $status -ne 0
        print_error "Build failed. See /tmp/surf_build.log for details."
        less /tmp/surf_build.log
        exit 1
    end
end

print_success "Done"
