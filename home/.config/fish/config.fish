# Aliases
alias ls='lsd -l'
alias cat="bat"
alias tree="erd"
alias clip="xclip -selection clipboard"
alias reload="source ~/.config/fish/config.fish"
alias sst="sudo systemctl-tui"
alias lg="lazygit"

fish_add_path /home/bas/.local/bin

# Disable greeting message
set fish_greeting

# Configure hydro prompt
set --global fish_prompt_pwd_dir_length 4
set --global hydro_fetch true

# Source mcfly
mcfly init fish | source
set -gx MCFLY_KEY_SCHEME vim

# Source rust
set -gx PATH "$HOME/.cargo/bin" $PATH;

# Source zoxide
zoxide init fish | source
