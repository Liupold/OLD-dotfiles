# Liupold's Dotfiles

For:
* X11 (xintrc/Xresources)
* alacritty
* bin (some useful scripts)
* bspwm (A fantastic WM)
* cmus (A very versatile Music Player (With Screen))
* colors (uniform colors for everyplace)
* dunst (A really great notification manager)
* gtk-3.0 (setting for gtk theme)
* kitty (A cute little terminal)
* newsboat (Best rss reader, YouTube client 😉)
* npm (Just added to clean files from home)
* mpv (keyboard bindings h,j,k,l vim like)
* polybar (Most responsive bar EVER)
* ranger (The Way to browse files in linux)
* lf (The Faster Way to browse files in linux)
* sxhkd (A fantastic keyboard daemon)
* sxiv (A great image viewer)
* nvim (Need no introduction)
* zathura (A simple and light Reader PDF, DJVU, EPUB)
* zsh (Best shell in my opinion)
* youtube-viewer (as the name suggests)

Automating the install process

Make sure you have all the required packages, stow, git installed.

If using arch you can use dri (dotfiles requirements installer)

```
./dri [PACKAGES..]
```

### cloning repo to your home folder

```consol
cd ~ && git clone https://github.com/liupold/dotfiles && cd dotfiles
```

# Installing dotfiles

```consol
. ./dots.sh
```
* all

```
./dls -vS "$dot_all"
```

* only terminal based

```
./dls -vS "$dot_term"
```
Learn more about [dls](https://github.com/Liupold/dls).
