DRIVES="$(lsblk | grep -v 'sda.*$' | grep -v 'part $' | grep -o 's.*part' | awk '{ print $1 " ("$4")" }')"

SELECTED_DRIVE="$(echo "$DRIVES" | dmenu -p "Unmount?: " -fn "Fira Code-13" | awk '{ print $1 }')"

if [ -z $SELECTED_DRIVE ]
then
	exit 0
fi

sudo umount "/dev/$SELECTED_DRIVE"
if [ $? -eq 0 ]
then
	notify-send -a "USB-UNMOUNTER" "UnMounted" "$SELECTED_DRIVE is safe to remove."
	exit 0
else
	notify-send -a "USB-MOUNTER" "Failed" "unable to umount $SELECTED_DRIVE" -u critical
	exit 1
fi
