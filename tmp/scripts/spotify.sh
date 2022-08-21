#!/bin/bash

spotify_setup(){
    print_info "\nSetting up spotify...\n"
    if [ -f ~/.config/spotify-tui/client.yml ]; then
        print_warning "spotify already set up, skipping.\n"
        return 0
    fi

    while true
    do
        read -r -p "Do you have a client file? [Y/n] " input

        case $input in
            [yY][eE][sS]|[yY])
                read -rep "Enter file location: " file_location

                full_path="${file_location/\~/$HOME}"

                if [ ! -f full_path ]; then
                    print_error "\nFile not found. Exiting spotify setup."
                    return 1;
                fi

                sudo cp -f $full_path ~/.config/spotify-tui/

                break
                ;;
            [nN][oO]|[nN])
                print_info "\n\nSetting up SPT manually...\n"
                sleep 3
                sudo spt
                sleep 2
                break
                ;;
            *)
                echo "Invalid input..."
                ;;
        esac
    done
    print_success "Done!\n"
}
