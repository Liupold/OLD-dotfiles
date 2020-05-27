[ -f './dls' ] || \
        curl "https://raw.githubusercontent.com/Liupold/dls/master/dls" > ./dls
chmod +x ./dls

export dot_all='X11 alacritty bin bspwm dunst gtk-3.0 kitty dmenu
luna_theme newsboat npm polybar lf sxhkd sxiv vim nvim zathura zsh cmus mpv python'

export dot_term='bin luna_theme newsboat npm lf vim nvim zsh cmus mpv python'

