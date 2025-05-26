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

function dot-add
    if test (count $argv) -lt 1
        echo "Usage: dot-add <path> [--dry-run]"
        return 1
    end

    set dry_run 0
    for arg in $argv
        if test $arg = "--dry-run"
            set dry_run 1
        end
    end

    for arg in $argv
        if not string match -q -- "--*" $arg
            set full_path (realpath $arg)
            break
        end
    end

    if not test -e $full_path
        echo "Error: '$full_path' does not exist."
        return 1
    end

    set rel_path (string replace -- "$HOME/" "" $full_path)
    set target_path "$HOME/dotfiles/home/$rel_path"

    echo ""
    echo "Source: $full_path"
    echo "Target: $target_path"
    echo ""

    if test $dry_run -eq 1
        echo "[DRY RUN] Would move: $full_path → $target_path"
    else
        mkdir -p (dirname $target_path)
        mv $full_path $target_path
        stow -d ~/dotfiles -t ~ home
    end
end

