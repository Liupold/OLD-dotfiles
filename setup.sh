mkdir -p ~/.config
mkdir -p ~/.local/bin
mkdir -p ~/.local/share/

# defaults
OVERWRITE_FILES=0
OVERWRITE_LINKS=1
DRY=1


echo "$@" | grep -q -e '--sync' && \
        echo "W: Making Changes Permanent!" && DRY=0

[ "$DRY" -eq 1 ] && echo "Running in dry mode use '--sync' to finalize."

echo "$@" | grep -q -e '--overwrite-files' && \
        echo "W: overwriting files!" && OVERWRITE_FILES=1

mcf() {
        mkdir -p ~/.config/$1
}

resolveL() {
        [ "$OVERWRITE_LINKS" -eq 1 ] && [ "$DRY" -eq 0 ] && \
                rm $1
        [ "$OVERWRITE_LINKS" -eq 1 ] && echo "Removing(link) $1"
}


resolveF() {
        [ "$OVERWRITE_FILES" -eq 1 ] && [ "$DRY" -eq 0 ] && \
                rm $1
        [ "$OVERWRITE_FILES" -eq 1 ] && echo "Removing $1"
}

resolve() {
        for file in $conflicts
        do
                eval "file=$(realpath ~/$file)"

                if [ -L "$file" ]
                then
                        [ "$OVERWRITE_LINKS" -eq 0 ] && \
                                echo "CONFLICT: \"$file\" (link)"
                        resolveL $file
                elif [ -f "$file" ]
                then
                        [ "$OVERWRITE_FILES" -eq 0 ] && \
                                echo "CONFLICT: \"$file\""
                        resolveF $file
                else
                        "E: $file required manual resolve."
                fi
        done
}



lp() {

        [ "$DRY" -eq 1 ] && \
                conflicts="$(stow --simulate $1 2>&1 | awk '/*/{print $11}')"
        [ "$DRY" -eq 0 ] && \
                conflicts="$(stow $1 2>&1 | awk '/*/{print $11}')"

        [ -z "$conflicts" ] && echo "Linked $1! (no conflicts)"
        if [ -n "$conflicts" ]
        then
            resolve "$conflicts"
            return_code=$?

            [ "$return_code" -ne 0 ] && echo "E: Failed for $1"
            [ "$return_code" -eq 0 ] && echo "resolved conflicts $1"
            [ "$return_code" -eq 0 ] && [ "$DRY" -eq 0 ]&& lp $1
        fi
}

lp bin

mcf X11 && lp X11
mcf alacritty && lp alacritty
mcf bspwm && lp bspwm
mcf cmus && lp cmus
mcf colors && lp colors
mcf dunst && lp dunst
mcf 'gtk-3.0' && lp 'gtk-3.0'
mcf kitty && lp kitty
mcf newsboat && lp newsboat
mcf npm && lp npm
mcf polybar && lp polybar
mcf ranger && lp ranger
mcf sxhkd && lp sxhkd
mcf sxiv && lp sxiv
mcf vim && lp vim
mcf zathura && lp zathura
mcf zsh && lp zsh

[ "$DRY" -eq 1 ] && echo "(DONE!) use '--sync' to finalize."
exit 0
