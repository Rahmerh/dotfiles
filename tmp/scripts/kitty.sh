#!/bin/bash
kitty_replace_icon(){
    print_info "\nReplacing kitty's icon...\n"
    if brew info kitty > /dev/null; then
        cp ~/.config/kitty/kitty.icns /Applications/kitty.app/Contents/Resources/kitty.icns
        rm /var/folders/*/*/*/com.apple.dock.iconcache
        touch /Applications/kitty.app
        killall Dock && killall Finder
    else
        print_error "Kitty was not installed, please check the Brewfile\n"
    fi
    print_success "Done!\n"
}
