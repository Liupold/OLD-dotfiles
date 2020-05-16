
echo $(tty) | grep -q '^/dev/tty.$' && [ -f $HOME/.cache/wal/colors-tty.sh ] && sh $HOME/.cache/wal/colors-tty.sh
echo $(tty) | grep -q '^/dev/tty.$' && neofetch
echo $(tty) | grep -q '^/dev/tty.$'  && [ -f /usr/share/kbd/consolefonts/ter-powerline-v20b.psf.gz ] && setfont /usr/share/kbd/consolefonts/ter-powerline-v20b.psf.gz

#[ "$(tty)" = "/dev/tty1" ] &&  printf "start Xorg? (y/n)" && read -k ans && [ "$ans" = "y" ] &&
[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x Xorg >/dev/null && startx "$XDG_CONFIG_HOME/X11/xinitrc" -- >/dev/null 2>&1
