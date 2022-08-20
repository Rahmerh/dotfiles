#!/bin/bash
__do_update() {
    export NONINTERACTIVE=1
    brew update
    brew outdated
    brew upgrade
}

__do_install() {
    print_info "installing homebrew ($(uname)).."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" &&
    print_success "completed installing brew." ||
    exit 1
}

brew_install(){
    if type "brew" &>/dev/null; then
        print_warning "brew already installed; updating instead.\n"
        __do_update
    else
        __do_install && do_update
    fi
}

install_package() {
    print_info "Installing $1...\n"
    brew install $1 -q
    print_success "Done!\n"
}

brew_bundle() {
    print_info "\nInstalling packages...\n\n"

    brew bundle --file=./brew/Brewfile

    if [ "$SHELL" != "/opt/homebrew/bin/fish" ]; then
        print_info "\nSetting fish as your default shell\n\n"

        sudo sh -c 'echo /opt/homebrew/bin/fish >> /etc/shells'
        chsh -s /opt/homebrew/bin/fish
    fi
    print_success "Done!\n"
}
