#!/bin/sh

store="$HOME/.password-store"

if [[ $# -eq 0 ]]; then
    find "$store" -type f -name '*.gpg' \
        | sed "s|$store/||;s|\.gpg$||" \
        | sort
else
    entry="$1"
    pass -c "$entry" >/dev/null
fi
