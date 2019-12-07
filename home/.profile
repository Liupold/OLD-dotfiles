XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME
export LESSHISTFILE="-"

[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && startx
