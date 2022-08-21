#!/bin/bash

slack_setup (){
    print_info "\nSetting up slack...\n"

    if [ -f $HOME/.config/slack-term/config/.slack-term ]; then
        print_warning "Slack already set up, skipping."
        return 0
    fi

    go install github.com/erroneousboat/slack-term@latest

    sudo mv -f ~/go/bin/slack-term /usr/local/bin

    print_info "Please open the following link in your browser: \n"
    print_warning "https://slack.com/oauth/authorize?client_id=91899392594.382712253827&scope=client"
    print_info "\nWhen you have done so, please copy the code from the url and paste here it below.\n"

    read -r -p "Code: " code

    response=$(curl -s "https://slack.com/api/oauth.access?client_id=91899392594.382712253827&client_secret=c7986be41b6ddb478041d1848dad5f6e&code=$code" | jq .access_token)

    if [ ! -d $HOME/.config/slack-term/config ]; then
        sudo mkdir $HOME/.config/slack-term/config
    fi

    sudo bash -c "echo '{ \"slack_token\": $response }' > $HOME/.config/slack-term/config/.slack-term"

    print_success "Done!\n"
}
