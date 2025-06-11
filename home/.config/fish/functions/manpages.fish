function list-manpages --description "List installed man pages from a given package"
    if test (count $argv) -eq 0
        echo "Usage: list-manpages <package_name>"
        return 1
    end

    pacman -Ql "$argv[1]" |
        awk '{ print $2 }' |
        grep '/man[1-9]/.*\.[0-9]\(\.gz\)\?$' |
        while read -l file
            echo (string replace -r '\.[0-9](\.gz)?$' '' (basename $file))
        end |
        sort
end
