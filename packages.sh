[ -f './dls' ] || \
        curl "https://raw.githubusercontent.com/Liupold/dls/master/dls" > ./dls
chmod +x ./dls

export dot_all='X11 alacritty bin bspwm dunst gtk-3.0 kitty
luna_theme newsboat npm polybar ranger sxhkd sxiv vim zathura zsh cmus'

export dot_term='bin luna_theme newsboat npm ranger vim zsh cmus'

