# Aliases
alias ls='lsd -l'
alias cat="bat"
alias reload="source ~/.config/fish/config.fish"
alias sst="sudo systemctl-tui"
alias lg="lazygit"
alias surf='env GDK_BACKEND=x11 WEBKIT_DISABLE_COMPOSITING_MODE=1 surf'

fish_add_path /home/bas/.local/bin

# Disable greeting message
set fish_greeting

function fish_prompt
    set -l last_status $status
    set -l branch (command git rev-parse --abbrev-ref HEAD 2>/dev/null)


    # Path: just ~ (home) or full pwd if outside home
    set -l path (string replace $HOME '~' (pwd))

    echo -n "$path"

    if test -n "$branch"
        set -l dirty (command git status --porcelain | wc -l)
        set -l unpushed (command git rev-list --count @{u}..HEAD)

        if test $dirty -gt 0
            set_color red
        end

        echo -n " $branch"
        set_color normal

        if test $unpushed -gt 1
            echo -n "↑$unpushed"
        else if test $unpushed -eq 1
            echo -n '↑'
        end
    end

    if test $last_status -ne 0
        set_color red
    else
        set_color --bold '#E85A98'
    end

    echo -n ' ❱ '
    set_color normal
end

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
            set full_path "$(pwd -P)/$arg"
            break
        end
    end

    if not test -d "$full_path"
        echo "Error: $full_path is not a valid directory."
        return 1
    end

    set rel_path (string replace -- "$HOME/" "" $full_path)
    set target_path "$HOME/dotfiles/home/$rel_path"

    echo "Source: $full_path"
    echo "Target: $target_path"

    if test $dry_run -eq 1
        echo "[DRY RUN] mv $full_path $target_path"
        echo "[DRY RUN] stow -d ~/dotfiles -t ~ home"
    else
        mkdir -p (dirname $target_path)
        mv $full_path $target_path
        stow -d ~/dotfiles -t ~ home
    end
end

function dot-remove
    if test (count $argv) -lt 1
        echo "Usage: dot-remove <path> [--dry-run]"
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
            set full_path "$(pwd -P)/$arg"
            break
        end
    end

    if not test -d "$full_path"
        echo "Error: $full_path is not a valid directory."
        return 1
    end

    set rel_path (string replace -- "$HOME/" "" $full_path)
    set dotfile_path "$HOME/dotfiles/home/$rel_path"

    if not test -d "$dotfile_path"
        echo "Error: $dotfile_path is not a valid directory."
        return 1
    end

    echo "Unlinking: $full_path"
    echo "Restoring: $dotfile_path → $full_path"
    echo "Deleting from dotfiles: $dotfile_path"

    if test $dry_run -eq 1
        echo "[DRY RUN] stow -D -d ~/dotfiles -t ~ home"
        echo "[DRY RUN] cp -r $dotfile_path $full_path"
        echo "[DRY RUN] rm -rf $dotfile_path"
    else
        stow -D -d ~/dotfiles -t ~ home
        mkdir -p (dirname $full_path)
        cp -r $dotfile_path $full_path
        rm -rf $dotfile_path
    end
end

function list-manpages
    if test (count $argv) -eq 0
        echo "Usage: manpages <package_name>"
        return 1
    end
    pacman -Ql $argv[1] | awk '{ print $2 }' | grep '/man[1-9]/.*\.[0-9]\(\.gz\)\?$' | while read -l file
        echo (basename $file | sed -E 's/\.[0-9](\.gz)?$//')
    end | sort
end
