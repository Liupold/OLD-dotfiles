XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_HOME
export LESSHISTFILE="-"

# Default programs:
export EDITOR="vim"
export TERMINAL="urxvt"
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

[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && startx
