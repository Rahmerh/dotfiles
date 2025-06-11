function why
    set -l code $status

    if test $code -eq 0
        echo "Why what? Nothing went wrong."
        return 0
    end

    echo -n (set_color red)"$code"(set_color normal)

    switch $code
        case 1
            echo " – general error (e.g. test failed)"
        case 2
            echo " – misuse of shell builtins"
        case 126
            echo " – permission denied or not executable"
        case 127
            echo " – command not found"
        case 128
            echo " – invalid exit value or repo error"
        case 130
            echo " – terminated by Ctrl-C (SIGINT)"
        case 139
            echo " – segmentation fault"
        case '*'
            if test $code -ge 129 -a $code -le 255
                set -l signal (math $code - 128)
                switch $signal
                    case 9
                        echo " – killed (SIGKILL)"
                    case 15
                        echo " – terminated (SIGTERM)"
                    case '*'
                        echo " – exited via signal $signal"
                end
            else
                echo " – unknown or uncommon error"
            end
    end

    set -l last_cmd (history --max=1 | string trim | string replace -ra '^"|"$' '')
    set -l max_len 50
    if test (string length -- $last_cmd) -gt $max_len
        set shown_cmd (string sub -l $max_len $last_cmd)'... [truncated]'
    else
        set shown_cmd $last_cmd
    end

    echo "↳ \"$shown_cmd\""
end

function smart-tar
    if test (count $argv) -lt 2
        echo "Usage: smart-tar [--dereference] <archive-name> <files...>"
        return 1
    end

    set -l dereference false
    set -l args

    for arg in $argv
        switch $arg
            case --dereference
                set dereference true
            case '*'
                set -a args $arg
        end
    end

    if test (count $args) -lt 2
        echo "Missing archive name or file arguments"
        return 1
    end

    set -l archive $args[1]
    set -e args[1]

    set -l ext
    for known in gz bz2 xz
        if string match -q "*.$known" "$archive"
            set ext $known
            break
        end
    end

    if test -z "$ext"
        set -l size (du -cs --apparent-size --block-size=1M $args | grep total | awk '{print $1}')
        if test -z "$size"
            echo "Failed to determine archive size"
            return 1
        end

        if test $size -lt 50
            set ext gz
        else if test $size -lt 200
            set ext bz2
        else
            set ext xz
        end

        set archive "$archive.tar.$ext"
    end

    switch $ext
        case gz
            set tar_flags -czvf
        case bz2
            set tar_flags -cjvf
        case xz
            set tar_flags -cJvf
        case '*'
            echo "Unknown extension: .$ext"
            return 1
    end

    if $dereference
        tar $tar_flags $archive --dereference $args
    else
        tar $tar_flags $archive $args
    end
end
