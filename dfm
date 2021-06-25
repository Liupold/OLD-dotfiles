#!/bin/sh

ACTION="$1"
shift 1
export DFR="/home/rohnch/.local/dotfiles"

Err() {
        echo 'ERROR:' "$1" >&2
        [ -n "$2" ] && exit "$2"
}

sync() {
        module="$1"
        [ "$#" -ne 2 ] \
                && Err "Non proper number of args." \
                && Err "USEAGE: add module filepath" 1
        target_path="$(readlink -f "$2")"
        repo_path="$DFR/$module/${target_path#$HOME/}"

        [ ! -e "$target_path" ] && Err "file/dir does not exist!" 2
        [ -e "$repo_path" ] && Err "file/dir exists in repo!" 3

        mkdir  -p "$(dirname "$repo_path")" \
                && mv "$target_path" "$repo_path" \
                && ln -sr "$repo_path" "$target_path"
}

desync () {
        module="$1"
        if [ "$#" -eq 2 ]; then
                repo_path="$(readlink -f "$2")"
                target_path="$HOME${repo_path#$DFR/$module}"
                [ ! -L "$target_path" ] && Err "file/dir is not a link" 2
                [ ! -e "$repo_path" ] && Err "file/dir does not exists in repo!" 3

                [ -e "$target_path" ] \
                        && [ -L "$target_path" ] \
                        && mv "$repo_path" "$target_path"
        fi
}

[ "$ACTION" = "add" ] && sync "$@"
[ "$ACTION" = "remove" ] && desync "$@"

exit 0
