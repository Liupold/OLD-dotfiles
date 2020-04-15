export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME
export LESSHISTFILE="-"

# Default programs:
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="brave"
export READER="zathura"
export FILE="ranger"
export _JAVA_AWT_WM_NONREPARENTING=1

BINPATH="$HOME/bin"
PATH="$BINPATH:$PATH"

[ "$(tty)" = "/dev/tty1" ] && [ -f $HOME/.cache/wal/colors-tty.sh ] && sh $HOME/.cache/wal/colors-tty.sh
# [ "$(tty)" = "/dev/tty1" ] && neofetch
[ "$(tty)" = "/dev/tty1" ] && [ -f /usr/share/kbd/consolefonts/ter-powerline-v20b.psf.gz ] && setfont /usr/share/kbd/consolefonts/ter-powerline-v20b.psf.gz
#[ "$(tty)" = "/dev/tty1" ] &&  printf "start Xorg? (y/n)" && read -k ans && [ "$ans" = "y" ] &&
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && startx >/dev/null 2>&1
