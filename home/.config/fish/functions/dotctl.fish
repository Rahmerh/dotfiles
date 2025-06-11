function __dot_parse_args
    set -l dry_run 0
    set -l path_found 0
    set -l path

    for arg in $argv
        switch $arg
            case --dry-run
                set dry_run 1
            case '--*'
                continue
            case '*'
                if test $path_found -eq 0
                    set path (realpath "$arg")
                    set path_found 1
                end
        end
    end

    set -l current_function (status current-function)
    if test -z "$path"
        echo "Usage: $current_function <path> [--dry-run]"
        return 1
    end

    set -l rel_path (string replace -- "$HOME/" "" $path)
    set -l dot_path "$HOME/dotfiles/home/$rel_path"

    echo $dry_run
    echo $path
    echo $rel_path
    echo $dot_path
end

function dot-add
    set -l result (__dot_parse_args $argv)
    or return 1

    set -l dry_run $result[1]
    set -l full_path $result[2]
    set -l target_path $result[4]

    if not test -d "$full_path"
        echo "Error: $full_path is not a valid directory."
        return 1
    end

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
    set -l result (__dot_parse_args $argv)
    or return 1

    set -l dry_run $result[1]
    set -l full_path $result[2]
    set -l dotfile_path $result[4]

    if not test -d "$full_path"
        echo "Error: $full_path is not a valid directory."
        return 1
    end

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
