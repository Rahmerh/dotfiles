#!/bin/sh

draw() {
  kitten icat --stdin no --transfer-mode memory --place "${w}x${h}@${x}x${y}" "$1" </dev/null >/dev/tty
  exit 1
}

file="$1"
w="$2"
h="$3"
x="$4"
y="$5"

mime=$(file -Lb --mime-type "$file")

case "$mime" in
  image/*)
    draw "$file"
    ;;
  application/zip)
    unzip -l "$file"
    ;;
  application/x-tar | application/gzip | application/x-xz | application/x-bzip2)
    tar -tf "$file"
    ;;
  application/x-rar)
    unrar l "$file"
    ;;
  *)
    cat "$file"
    ;;
esac
