mkdir -p ~/.config
mkdir -p ~/.local/bin/
mkdir -p ~/.local/share/

# defaults
OVERWRITE_FILES=0
OVERWRITE_LINKS=1
DRY=1
D_STOW=0

RED='\033[0;31m'
YELLOW='\033[0;33m '
NC='\033[0m'

extras='bin'
configs='X11 alacritty bspwm luna_theme gtk-3.0 dunst
kitty newsboat npm polybar ranger sxhkd sxiv vim zathura zsh'
tty_only='bin X11 newsboat npm ranger vim zsh'

to_stow=""

WARN() {
        msg="$1"
        printf "${YELLOW}W${NC}: $msg\n"
}

Err() {
        msg="$1"; code=$2
        printf "${RED}E${NC}: $msg\n"
        exit $code
}

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
                                Err "CONFLICT: \"$file\" (link)" 1
                        resolveL $file
                elif [ -f "$file" ]
                then
                        [ "$OVERWRITE_FILES" -eq 0 ] && \
                        Err "CONFLICT: \"$file\" (Tip: Backup the file and use -O)" 1
                        resolveF $file
                else
                        Err "$file required manual resolve." 2
                fi
        done
}


lp() {
        [ "$DRY" -eq 1 ] && \
                stow_out="$(stow --simulate $1 2>&1)"
        echo $stow_out | grep 'ERROR:' && exit 1
        [ "$DRY" -eq 0 ] && \
                stow_out="$(stow -v $1 2>&1)"

        conflicts="$(echo "$stow_out" | awk '/*/{print $11}')"

        [ -z "$conflicts" ] && echo -e "$stow_out" | grep 'LINK'
        [ -z "$conflicts" ] && echo "no conflicts: $1"

        if [ -n "$conflicts" ]
        then
            resolve "$conflicts"
            return_code=$?

            [ "$return_code" -eq 0 ] && echo "resolved conflicts: $1"
            [ "$return_code" -eq 0 ] && [ "$DRY" -eq 0 ]&& lp $1

        fi
}

mcf_and_lp() {
        for sf in $1
        do
                mcf $sf && lp $sf
        done
}

del() {
        for sf in $1
        do
                stow -D $1
        done
}

for option in $@
do
        if  [ $(echo $option | grep -e '-O\|--overwrite-file') ]
        then
                OVERWRITE_FILES=1 && continue
        elif  [ $(echo $option | grep -e '-S\|--sync') ]
        then
                DRY=0 && continue
        elif  [ $(echo $option | grep -e '-D\|--del') ]
        then
                D_STOW=1
        elif  [ $(echo $option | grep -e '-h\|--help') ]
        then
                DRY=0 && continue
        elif [ $(echo $option | grep -e '-.*') ]
        then
                Err "Unrecognised Option '$option'" 1
        elif [ $(echo $option | grep -e 'all') ]
        then
                to_stow="$extras $configs"
        elif [ $(echo $option | grep -e 'tty_only') ]
        then
                to_stow="$tty_only"
        else
                # add packages to stow
                to_stow="$to_stow $option"
        fi

done
[ "$D_STOW" -eq 1 ] && del "$to_stow"
[ "$D_STOW" -eq 0 ] && mcf_and_lp "$to_stow"
[ $DRY -eq 1 ] && WARN "Dry run nothing is modified. (Tip use -S)"
exit 0
