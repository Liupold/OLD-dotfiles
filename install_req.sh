#!/bin/sh
grep -qe 'NAME=\"Arch Linux\"' /etc/os-release && distro='archlinux'

REQ_DIR='./REQUIREMENT/'

WARN() {
        echo "WARNING: $1"
}

ERR() {
        echo "ERROR: $1" >&2
        [ -z "$2" ] && return 1 # if no code is specified
        exit "$2"
}

UPDATE_DATABASE() {
        [ "$distro" = "archlinux" ] && sudo pacaman -Syy && return 0
}

GET_INSTALL_LIST() {
        [ "$distro" = "archlinux" ] && pacman -Qq && return 0
}

INSTALLED_LIST="$(GET_INSTALL_LIST)"

OMMIT_INSTALLED() {
        TO_INSTALL="$1"
        for pkg_to_install in $TO_INSTALL
        do
                echo "$INSTALLED_LIST" | grep -q -e "$pkg_to_install" && \
                        TO_INSTALL="$(echo "$TO_INSTALL" | grep -v "$pkg_to_install")"
        done
        echo "$TO_INSTALL"
}

CHECK_BEFORE_INSTALL() {
        TO_INSTALL="$1"
        FAILED_PKS=""
        echo "The following packages will be installed:"
        if [ "$distro" = 'archlinux' ]; then
                for pkg_to_install in $TO_INSTALL
                do
                        pacman -Ss "^$pkg_to_install$" \
                                || FAILED_PKS="$FAILED_PKS $pkg_to_install"
                done
        fi
        [ -n "$FAILED_PKS" ] && echo Failed to locate PKG\(s\): "$FAILED_PKS" \
                && return 1
        return 0
}

INSTALL_PKGs() {
        TO_INSTALL="$1"
        TO_INSTALL="$(OMMIT_INSTALLED "$TO_INSTALL")"
        [ -z "$TO_INSTALL" ] && return 0 # empty list
        CHECK_BEFORE_INSTALL "$TO_INSTALL"
        TO_INSTALL="$(echo "$TO_INSTALL" | tr '\r\n' ' ')" # removing newline
        [ "$distro" = "archlinux" ] && \
                sudo pacman --noconfirm -S $TO_INSTALL && return 0
}

_PIP_INSTALL() {
        [ -z "$1" ] && return 0 # empty list
        PIP_TO_INSTALL="$(echo "$1" | tr '\r\n' ' ')" # removing newline
        sudo -H pip install "$PIP_TO_INSTALL"
}

_AUR_INSTALL() {
        # Make sure you have yay
        AUR_TO_INSTALL="$1"
        AUR_TO_INSTALL="$(OMMIT_INSTALLED "$AUR_TO_INSTALL")"
        [ -z "$AUR_TO_INSTALL" ] && return 0 # empty list
        FAILED_PKS=""
        for pkg_to_install in $AUR_TO_INSTALL
        do
                echo AUR checking "$pkg_to_install"...
                yes '' | yay "$pkg_to_install" >/dev/null 2>&1 \
                        || FAILED_PKS="$FAILED_PKS $pkg_to_install"

        done
        [ -n "$FAILED_PKS" ] && echo Failed to locate PKG\(s\): "$FAILED_PKS" \
                && return 1
        AUR_TO_INSTALL="$(echo "$AUR_TO_INSTALL" | tr '\r\n' ' ')" # removing newline
        yay -S --noconfirm $AUR_TO_INSTALL
}

ADDITIONAL_INSTALL() {
        INSTALL_LINEs="$1"
        AUR=""; PIP=""
        for install_line in $INSTALL_LINEs
        do
                echo "$install_line" | grep -q -e '^-A.*' \
                        && AUR="$AUR $install_line\n"
                echo "$install_line" | grep -q -e '^-P.*' \
                        && PIP="$PIP $install_line\n"
        done
        _AUR_INSTALL "$(echo -e "$AUR" | sed 's|-A:||g')"
        _PIP_INSTALL "$(echo -e "$PIP" | sed 's|-P:||g')"
}

STOW_PKG_TO_INSTALL="$@"

[ -d "$REQ_DIR/$distro" ] \
        || ERR "$distro is not supported by this dot files" 1 # check dolfiles (dry run)

ALL_INSTALL_LIST=""

for stow_pkg in $@
do
        [ -d "$stow_pkg" ] \
                || ERR "$stow_pkg not found!" 1 # check dolfiles (dry run)
        [ -f "$REQ_DIR/$distro/req-$stow_pkg" ] \
                || ERR "$pkg_to_install is missing a req-$pkg_to_install" 1
        ALL_INSTALL_LIST="$ALL_INSTALL_LIST""$(cat "$REQ_DIR/$distro/req-$stow_pkg")\n"
done

S_PKGs="$(echo -e "$ALL_INSTALL_LIST" | grep -v -e '^-.*$' | uniq -u)"
A_PKGs="$(echo -e "$ALL_INSTALL_LIST" | grep -o -e '^-.*$' | uniq -u)"
