#!/usr/bin/env bash
# ===========================================
# TokyoNight Storm Ranger Preview Script
# ===========================================

set -o noclobber -o noglob -o nounset -o pipefail
IFS=$'\n'

path="$1"  # Full path of file
width="$2"
height="$3"

mimetype=$(file --mime-type -Lb "$path")

case "$mimetype" in
    text/*)
        bat --color=always --style=plain --paging=never "$path" 2>/dev/null \
        || highlight --out-format=ansi "$path" 2>/dev/null \
        || cat "$path"
        exit 0
        ;;
    image/*)
        if command -v ueberzug &>/dev/null; then
            ueberzug layer --silent --parser bash 2>/dev/null &
        elif command -v chafa &>/dev/null; then
            chafa -s "$width"x"$height" "$path"
        else
            echo "No image preview backend found."
        fi
        exit 0
        ;;
    application/pdf)
        pdftotext "$path" - | head -n 50
        exit 0
        ;;
    *)
        file -b "$path"
        exit 1
        ;;
esac

