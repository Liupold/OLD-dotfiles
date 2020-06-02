[ -f './dls' ] || \
        curl "https://raw.githubusercontent.com/Liupold/dls/master/dls" > ./dls
chmod +x ./dls

# dots in general
export dot_all='X11 alacritty bin bspwm dunst gtk-3.0 kitty dmenu ranger youtube-viewer
luna_theme newsboat npm polybar lf sxhkd sxiv nvim zathura zsh cmus mpv python'

export dot_term='bin luna_theme newsboat npm lf nvim zsh cmus mpv python youtube-viewer'
export dot_gui_minimal='X11 bspwm dunst gtk-3.0 dmenu luna_theme sxhkd sxiv polybar mpv'
