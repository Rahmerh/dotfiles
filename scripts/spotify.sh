#!/bin/bash

spotify_setup(){

    if [ -f ~/.config/spotify-tui/client.yml ]; then
        print_warning "Spotify already set up, skipping."
        return 0
    fi

    while true
    do
        read -r -p "Do you have a client file? [Y/n] " input

        case $input in
            [yY][eE][sS]|[yY])
                echo "Yes"
                break
                ;;
            [nN][oO]|[nN])
                print_info "\n\nSetting up SPT manually...\n"
                sleep 3
                sudo spt
                sleep 2
                print_success "Done!\n"
                break
                ;;
            *)
                echo "Invalid input..."
                ;;
        esac
    done
}
