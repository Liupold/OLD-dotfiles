XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME
export LESSHISTFILE="-"

# Default programs:
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="chromium"
export READER="zathura"
export FILE="ranger"


# xsecure lock
export XSECURELOCK_PASSWORD_PROMPT="time"
export XSECURELOCK_LIST_VIDEOS_COMMAND="find ~/Walls/LockVid"
export XSECURELOCK_SAVER="saver_mpv"
export XSECURELOCK_SHOW_DATETIME=1
export XSECURELOCK_NO_COMPOSITE=1 # till picom is supported

BINPATH="$HOME/bin"
PATH="$BINPATH:$PATH"

[ "$(tty)" = "/dev/tty1" ] && neofetch
[ "$(tty)" = "/dev/tty1" ] && [ -f /usr/share/kbd/consolefonts/ter-powerline-v20b.psf.gz ] && setfont /usr/share/kbd/consolefonts/ter-powerline-v20b.psf.gz
[ "$(tty)" = "/dev/tty1" ] &&  printf "start Xorg? (y/n)" && read -k ans && [ "$ans" = "y" ] && ! pgrep -x Xorg >/dev/null && startx >/dev/null 2>&1

