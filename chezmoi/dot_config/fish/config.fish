eval "$(/opt/homebrew/bin/brew shellenv)"

# Aliases
alias ls='lsd'
alias la='ls -la'
alias cat="bat"
alias cal="khal interactive"
alias search="ddgr"
alias ping="gping"

# Keybindings
# Cmd + e
bind \[101\;9u ranger

# Disable greeting message
set fish_greeting

# Alias & source thefuck
thefuck --alias | source

# Source autojump
[ -f /opt/homebrew/share/autojump/autojump.fish ]; and source /opt/homebrew/share/autojump/autojump.fish
