eval "$(/opt/homebrew/bin/brew shellenv)"

# Aliases
alias ls='lsd'
alias la='ls -la'
alias cat="bat"
alias cal="khal interactive"
alias search="ddgr"
alias ping="gping"
alias kafka="kaskade $KASKADE_CONFIG"

# Keybindings
# Cmd + e
bind \[101\;9u ranger

# Disable greeting message
set fish_greeting

# Source autojump
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish

# Configure hydro prompt
set --global fish_prompt_pwd_dir_length 4
set --global hydro_fetch true

# Source mcfly
mcfly init fish | source
set -gx MCFLY_KEY_SCHEME vim
