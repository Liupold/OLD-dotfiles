[ -f './dls' ] || \
        curl "https://raw.githubusercontent.com/Liupold/dls/master/dls" > ./dls
chmod +x ./dls

# dots in general
export dot_all='X11 alacritty bin bspwm dunst gtk-3.0 kitty dmenu
luna_theme newsboat npm polybar lf sxhkd sxiv vim nvim zathura zsh cmus mpv python'

export dot_term='bin luna_theme newsboat npm lf vim nvim zsh cmus mpv python'

# in python pip
export python_pip="$(grep --no-filename -e '^-P:' REQUIREMENT/archlinux/* | sed 's|^-P:||g' | uniq)"

# arch-linux (in official repo)
export arch_linux_pacman="$(grep --no-filename -v '^-' REQUIREMENT/archlinux/* | uniq)"
export arch_linux_aur="$(grep --no-filename -e '^-A:' REQUIREMENT/archlinux/* | sed 's|^-A:||g' | uniq) st-luke-git"

