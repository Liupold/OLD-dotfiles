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

```
.
├── alacritty
│   └── .config
│       └── alacritty
│           └── alacritty.yml
├── bin
│   └── .local
│       └── bin
│           ├── autopauseD
│           ├── batch-rename
│           ├── booksplit
│           ├── dmenu
│           ├── link-handler
│           ├── pfetch
│           ├── recognize_song
│           ├── rssadd
│           ├── show-weather
│           ├── tag
│           └── wttrup
├── bspwm
│   ├── .config
│   │   └── bspwm
│   │       └── bspwmrc
│   └── .local
│       └── bin
│           └── bspwm-update-color
├── cmus
│   ├── .config
│   │   └── cmus
│   │       ├── cmus-status.sh
│   │       └── rc
│   └── .local
│       └── bin
│           ├── cmus
│           ├── dmenu-cmus
│           └── lyric
├── cron
│   └── .local
│       └── bin
│           └── notice_board.sh
├── dls
├── dots.sh
├── dunst
│   ├── .config
│   │   └── dunst
│   │       └── dunstrc
│   └── .local
│       └── bin
│           └── start-dunst
├── emoji-menu
│   └── .local
│       ├── bin
│       │   └── dmenuunicode
│       └── share
│           └── emoji
├── .github
│   └── workflows
│       └── blank.yml
├── .gitignore
├── gtk-3.0
│   └── .config
│       └── gtk-3.0
│           └── settings.ini
├── kitty
│   └── .config
│       └── kitty
│           └── kitty.conf
├── lf
│   └── .config
│       └── lf
│           ├── icons.sh
│           ├── lfrc
│           └── pv.sh
├── luna_theme
│   └── .config
│       └── luna_theme
│           ├── colors-kitty.conf
│           ├── colors.sh
│           ├── colors-tty.sh
│           ├── colors.Xresources
│           ├── sequences
│           └── WALL.jpg
├── mpv
│   ├── .config
│   │   └── mpv
│   │       ├── input.conf
│   │       └── mpv.conf
│   └── .local
│       └── bin
│           └── yplay
├── newsboat
│   ├── .config
│   │   └── newsboat
│   │       └── config
│   └── .local
│       └── bin
│           ├── newsboat
│           └── newsup
├── npm
│   └── .config
│       └── npm
│           └── npmrc
├── nvim
│   ├── .config
│   │   └── nvim
│   │       ├── colors
│   │       │   ├── gruvbox.vim
│   │       │   └── molokai.vim
│   │       └── init.vim
│   └── .local
│       └── bin
│           └── latexrun
├── octave
│   └── .config
│       └── octave
│           └── octaverc
├── polybar
│   └── .config
│       └── polybar
│           ├── config
│           └── scripts
│               ├── network-traffic.sh
│               └── speaker_symbol.sh
├── python
│   └── .config
│       └── python
│           └── pystartup.py
├── ranger
│   └── .config
│       └── ranger
│           ├── rc.conf
│           ├── rifle.conf
│           ├── scope.sh
│           └── shortcuts.conf
├── README.md
├── REQUIREMENT
│   └── ArchLinux
│       ├── alacritty
│       ├── bin
│       ├── bspwm
│       ├── cmus
│       ├── dunst
│       ├── gtk-3.0
│       ├── kitty
│       ├── lf
│       ├── luna_theme
│       ├── mpv
│       ├── newsboat
│       ├── npm
│       ├── nvim
│       ├── polybar
│       ├── python
│       ├── sxhkd
│       ├── sxiv
│       ├── X11
│       ├── youtube-viewer
│       ├── zathura
│       └── zsh
├── sxhkd
│   └── .config
│       └── sxhkd
│           └── sxhkdrc
├── sxiv
│   └── .config
│       └── sxiv
│           └── exec
│               └── key-handler
├── TESTs
│   └── on-push-test
├── X11
│   ├── .config
│   │   ├── mimeapps.list
│   │   └── X11
│   │       ├── xinitrc
│   │       └── .Xresources
│   └── .local
│       ├── bin
│       │   ├── randbg
│       │   ├── screen-lock
│       │   ├── setbg
│       │   └── xsecure_mpv
│       └── share
│           └── applications
│               ├── file.desktop
│               ├── img.desktop
│               ├── mail.desktop
│               ├── pdf.desktop
│               ├── rss.desktop
│               ├── text.desktop
│               ├── torrent.desktop
│               └── video.desktop
├── youtube-viewer
│   └── .config
│       └── youtube-viewer
│           └── youtube-viewer.conf
├── zathura
│   └── .config
│       └── zathura
│           └── zathurarc
└── zsh
    ├── .config
    │   ├── aliasrc
    │   └── zsh
    │       ├── plugins
    │       │   └── zsh-syntax-highlighting
    │       │       ├── highlighters
    │       │       │   ├── brackets
    │       │       │   │   └── brackets-highlighter.zsh
    │       │       │   ├── cursor
    │       │       │   │   └── cursor-highlighter.zsh
    │       │       │   ├── line
    │       │       │   │   └── line-highlighter.zsh
    │       │       │   ├── main
    │       │       │   │   └── main-highlighter.zsh
    │       │       │   ├── pattern
    │       │       │   │   └── pattern-highlighter.zsh
    │       │       │   ├── regexp
    │       │       │   │   └── regexp-highlighter.zsh
    │       │       │   └── root
    │       │       │       └── root-highlighter.zsh
    │       │       ├── .revision-hash
    │       │       ├── .version
    │       │       ├── zsh-syntax-highlighting.plugin.zsh -> zsh-syntax-highlighting.zsh
    │       │       └── zsh-syntax-highlighting.zsh
    │       ├── .zprofile
    │       └── .zshrc
    └── .zshenv

110 directories, 116 files
```
