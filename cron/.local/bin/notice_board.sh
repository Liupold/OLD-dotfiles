#!/bin/sh

storage_file="$HOME/.cache/apc_notice"
current_file="$(mktemp "/tmp/XXXXXX")"

[ "$1" = '-d' ] && entry="$(sort -rg "$storage_file" | dmenu -b -l 10)" \
        && /usr/bin/xdg-open "http://apccollege.ac.in/news/admin/uploads/${entry##* }"
[ "$1" = '-d' ] && exit "$?"

/usr/bin/curl --silent 'http://apccollege.ac.in/news/admin/uploads/?C=M;O=I' \
        | while read -r entry; do
                [ "$entry" = "${entry#*href*pdf}" ] && continue
                entry="${entry#*href=\"}"
                file_name="${entry%%\"*}"

                entry="${entry#*align=\"right\">}"
                file_date="${entry%%  </td>*}"

                echo "$file_date" "$file_name"
        done > "$current_file"

[ ! -f "$storage_file" ] && echo "APC notice" \
        "empty cache, please check notice manually."

[ -f "$storage_file" ] && /usr/bin/diff "$storage_file" "$current_file" |\
        while read -r _change; do
                [ "$_change" = "${_change#>}" ] && continue
                _change="${_change#>}"
                echo  \
                        "APC notice: $_change"\
                        "http://apccollege.ac.in/news/admin/uploads/${_change##* }"
        done
mv "$current_file" "$storage_file"
