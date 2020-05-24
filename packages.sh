[ -f './dls' ] || \
        curl "https://raw.githubusercontent.com/Liupold/dls/master/dls" > ./dls
chmod +x ./dls

export dot_all='X11 alacritty bin bspwm dunst gtk-3.0 kitty
luna_theme newsboat npm polybar lf sxhkd sxiv vim zathura zsh cmus mpv'

export dot_term='bin luna_theme newsboat npm lf vim zsh cmus mpv'

