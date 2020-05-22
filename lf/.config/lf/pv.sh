#!/bin/sh
case "$1" in
        *.tar*) tar tf "$1";;
        *.zip) unzip -l "$1";;
        *.rar) unrar l "$1";;
        *.7z) 7z l "$1";;
        *.pdf) pdftotext "$1" -;;
        *)
                echo FILE: "$1"
                echo ------------------------------------------------------
                cat -n "$1" | head -n "$(echo "$2 - 5" | bc)"
                echo -e "\nTotal Lines: $(wc -l $1 | awk '{print $1}')"
                echo "Permision: $(ls -la $1 | awk '{print $1}')";;
esac

