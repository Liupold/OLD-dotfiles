XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME
export LESSHISTFILE="-"

# Default programs:
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="chromium"
export READER="zathura"
export FILE="ranger"

BINPATH="$HOME/bin"
PATH="$BINPATH:$PATH"

[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && startx
