#!/bin/bash

# Used to ask for sudo upfront.
ask_for_sudo() {
    print_info "\nChecking for sudo access...\n"
    sudo -v &> /dev/null
    while true; do
        sudo -n true
        sleep 60
        kill -0 "$$" || exit
    done &> /dev/null &
    print_success "Done!\n"
}



print_in_color() {
    printf "%b" \
        "$(tput setaf "$2" 2> /dev/null)" \
        "$1" \
        "$(tput sgr0 2> /dev/null)"
}

print_error() {
    print_in_color "$1" 1
}

print_success() {
    print_in_color "$1" 2
}

print_warning() {
    print_in_color "$1" 3
}

print_info() {
    print_in_color "$1" 6
}

change_wallpaper() {
    print_info "\nReplacing the wallpaper...\n"
    sqlite3 ~/Library/Application\ Support/Dock/desktoppicture.db "update data set value = '$1'";
    killall Dock;
    print_success "Done!\n"
}

create_symlink() {
    if [ ! -d $1 ]; then
        print_in_red "Given folder doesn't exist! Exiting"
        return 1
    fi

    if [ -d "$2/$3" ]; then
        rm -rf $d
    fi

    sudo ln -s "$1" $2
    print_info "\nCreated symlink for $3"
}

github_clone_latest() {
    local owner=$1 project=$2
    local output_directory="./tmp/$2"
    local release_url=$(curl -Ls -o /dev/null -w %{url_effective} https://github.com/$owner/$project/releases/latest)
    local release_tag=$(basename $release_url)
    git clone -b $release_tag -- https://github.com/$owner/$project.git $output_directory
}

prompt_yn (){
    while true
    do
        read -r -p "Are You Sure? [Y/n] " input

        case $input in
            [yY][eE][sS]|[yY])
                echo "Yes"
                break
                ;;
            [nN][oO]|[nN])
                echo "No"
                break
                ;;
            *)
                echo "Invalid input..."
                ;;
        esac
    done
}
