#!/bin/sh
grep -qe 'NAME=\"Arch Linux\"' /etc/os-release && distro='archlinux'

GET_INSTALL_LIST() {
        [ "$distro" = "archlinux" ] && pacman -Qq && return 0
}

OMMIT_INSTALLED() {
        INSTALLED_LIST="$1"; TO_INSTALL="$2"
        for pkg_to_install in $TO_INSTALL
        do
                echo -e "$INSTALLED_LIST" | grep -q -e "$pkg_to_install" && \
                        TO_INSTALL="$(echo "$TO_INSTALL" | grep -v "$pkg_to_install")"
        done
        echo "$TO_INSTALL"
}

CHECK_BEFORE_INSTALL() {
        TO_INSTALL="$1"
        if [ "$distro" = 'archlinux' ]; then
                for pkg_to_install in $TO_INSTALL
                do
                        pacman -Ss "^$pkg_to_install$" || \
                                echo "$pkg_to_install does not exist"
                done
        fi
}

INSTALL_PKGs() {
        TO_INSTALL="$(echo "$1" | tr '\r\n' ' ')" # removing whitespaces
        [ "$distro" = "archlinux" ] && echo -S "$TO_INSTALL" && return 0
}

INSTALLED_LIST="$(GET_INSTALL_LIST)"
TO_INSTALL="$(echo -e 'zsh\nfirefox')"
# TO_INSTALL="$(OMMIT_INSTALLED "$INSTALLED_LIST" "$TO_INSTALL")"
CHECK_BEFORE_INSTALL "$TO_INSTALL"
