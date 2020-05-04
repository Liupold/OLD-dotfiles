set -e
echo extracting \(st.tar.gz\)...
tar -xvzf st.tar.gz > /dev/null
cd ~/scripts/lpst/st

PATCH_DIR="$HOME/scripts/lpst/Patches"

patch() {
        name=$1
        file=$2
        echo "Patching $name($file)"
        git apply "$PATCH_DIR/$file"
        echo "Patched $name"
}

patch alpha 'st-alpha-0.8.2.diff'
patch clipboard 'st-clipboard-0.8.3.diff'
patch scrollback 'st-scrollback-20200419-72e3f6c.diff'
patch scrollback-mouse 'st-scrollback-mouse-20191024-a2c479c.diff'
patch scrollback-mouse-altscreen 'st-scrollback-mouse-altscreen-20200416-5703aa0.diff'
patch dracula 'st-autosync-0.8.3.diff'
patch ligatures 'st-ligatures-alpha-scrollback-20200430-0.8.3.diff'

patch fira-code_and_cur 'st-fira-code_and_cur.diff'
sed -i "1 i\#include \"/home/$USER/.cache/wal/colors-wal-st.h\"" config.def.h

echo 'Making....'
make > /dev/null
cp st ~/bin/st
rm -rf ~/scripts/lpst/st
