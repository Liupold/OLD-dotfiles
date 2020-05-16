#!/bin/sh
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

USER_BINPATH="$HOME/.local/bin/"

# zsh
mkdir -p "$XDG_CACHE_HOME/zsh"
export ZDOTDIR="$HOME/.config/zsh"
export HISTFILE="$XDG_CACHE_HOME/zsh/history"

#vim
mkdir -p "$XDG_DATA_HOME/vim/undo" "$XDG_DATA_HOME/vim/swap" "$XDG_DATA_HOME/vim/backup"
export VIMINIT="source $XDG_CONFIG_HOME/vim/vimrc"

# adb
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME/android"
export ADB_VENDOR_KEY="$XDG_CONFIG_HOME/android"

# cargo (rust)
export CARGO_HOME="$XDG_DATA_HOME/cargo"

# elinks
export ELINKS_CONFDIR="$XDG_CONFIG_HOME/elinks"

# gnupg
export GNUPGHOME="$XDG_DATA_HOME/gnupg"

#go
export GOPATH="$XDG_DATA_HOME/go"

# gtk2
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
mkdir -p "$XDG_CONFIG_HOME/gtk-2.0"

# gradle
export GRADLE_USER_HOME="$XDG_DATA_HOME/gradle"

# mplayer
export MPLAYER_HOME="$XDG_CONFIG_HOME/mplayer"

# parallel
export PARALLEL_HOME="$XDG_CONFIG_HOME/parallel"

#pylint
export PYLINTHOME="$XDG_CACHE_HOME/pylint"

#rustup
export RUSTUP_HOME="$XDG_DATA_HOME/rustup"

#urxvt
export RXVT_SOCKET="$XDG_RUNTIME_DIR/urxvtd"

#java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME/java"
export _JAVA_AWT_WM_NONREPARENTING=1

#npm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"

#less
export LESSHISTFILE="-"

# newsboat
mkdir -p "$XDG_DATA_HOME/newsboat" "$XDG_CONFIG_HOME/newsboat"

# Xauthority
export XAUTHORITY="$XDG_RUNTIME_DIR/Xauthority"

# Xorg
export XINITRC="$XDG_CONFIG_HOME/X11/xinitrc"

#Progs
export EDITOR="vim"
export TERMINAL="st"
export BROWSER="brave"
export READER="zathura --fork"
export FILE="ranger"
export MUSIC_PLAYER="cmus"


export PATH=$(find "$USER_BINPATH" -type d | tr '\n' ':' | sed 's/:$//'):${PATH}

# Luna Settings
export LUNA_WALL_DIR="$XDG_DATA_HOME/WALLS"
mkdir -p "$LUNA_WALL_DIR"
export LUNA_USE_PYWAL=1
export LUNA_COLOR_PATH="$XDG_DATA_HOME/luna_color"
export LUNA_WALL_PATH="$XDG_CONFIG_HOME/WALL"
export LUNA_YPLAY_RES="1080"
export LUNA_YPLAY_SCALE="0.6"
export LUNA_AUTO_PAUSE=1
export LUNA_MUSIC_DIR=""
export LUNA_DOWNLOAD_DIR=""

# colors
. ${LUNA_COLOR_PATH}/colors.sh
export foreground
export background
export cursor
export color0
export color1
export color2
export color3
export color4
export color5
export color6
export color7
export color8
export color9
export color10
export color11
export color12
export color13
export color14
export color15
