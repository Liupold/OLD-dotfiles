curl "https://raw.githubusercontent.com/Liupold/dls/master/dls" > ./dls
chmod +x ./dls

# download external scripts
mkdir -p bspwm/.local/bin
curl "https://raw.githubusercontent.com/Liupold/pidswallow/master/pidswallow" > bspwm/.local/bin/pidswallow
chmod +x bspwm/.local/bin/pidswallow

# dots in general
export dot_all='X11 alacritty bin bspwm dunst gtk-3.0 kitty ranger youtube-viewer
luna_theme newsboat npm polybar lf sxhkd sxiv nvim zathura zsh cmus mpv python emoji-menu'

export dot_term='bin luna_theme newsboat npm lf nvim zsh cmus mpv python youtube-viewer'
export dot_base="$dot_term X11 bspwm dunst gtk-3.0 luna_theme sxhkd sxiv polybar mpv emoji-menu"
