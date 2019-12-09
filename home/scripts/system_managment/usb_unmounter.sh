DRIVES="$(lsblk | grep -v 'sda.*$' | grep -v 'part $' | grep -o 's.*part' | awk '{ print $1 " ("$4")" }')"
MTP_D="$(awk '/simple-mtpfs/ { print $2 }' /etc/mtab| sed -e 's|^|(MTP)|g')"

SELECTED_DRIVE="$(echo "$DRIVES" "$MTP_D" | dmenu -p "Unmount?:" | awk '{ print $1 }')"

if [ -z $SELECTED_DRIVE ]
then
	exit 0
fi

if echo "$SELECTED_DRIVE" | grep -q "^(MTP).*"
then
	MOUNT_POINT=$(echo "$SELECTED_DRIVE" | sed -e "s|^(MTP)||g")
	fusermount -u $MOUNT_POINT
else
	sudo umount "/dev/$SELECTED_DRIVE"
fi


if [ $? -eq 0 ]
then
	notify-send -a "USB-UNMOUNTER" "UnMounted" "$SELECTED_DRIVE is safe to remove."
	exit 0
else
	notify-send -a "USB-MOUNTER" "Failed" "unable to umount $SELECTED_DRIVE" -u critical
	exit 1
fi
