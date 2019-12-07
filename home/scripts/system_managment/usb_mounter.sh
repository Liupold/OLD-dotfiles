DRIVES="$(lsblk | grep -v 'sda' | grep -o 'sd.*$' | grep -o '.*part $' | awk '{ print $1 " ("$4")" }')"
MTP_D="$(simple-mtpfs -l | sed 's|^.*:|(MTP)|g' | sed 's| |-|g')"
USB_MOUNT_POINT="/mnt\n/home/rohnch/USB\n[fstab]"
MTP_MOUNT_POINT="/mnt\n/home/rohnch/Phone\n/home/rohnch/MTP"

SELECTED_DRIVE="$(echo "$DRIVES" "$MTP_D" | dmenu -p "Mount?: " -fn "Fira Code-13" | awk '{ print $1 }')"

if [ -z $SELECTED_DRIVE ]
then
	exit 0
fi

if echo $SELECTED_DRIVE | grep -q '^(MTP)'
then

	SELECTED_MOUNT="$(echo -ne "$MTP_MOUNT_POINT" | dmenu -p "Mount Point: " -fn "Fira Code-13")"
else
	SELECTED_MOUNT="$(echo -ne "$USB_MOUNT_POINT" | dmenu -p "Mount Point: " -fn "Fira Code-13")"
fi

if [ -z $SELECTED_MOUNT ]
then
	exit 0
fi

if [ ! -d $SELECTED_MOUNT ] && [ $SELECTED_MOUNT != "[fstab]" ]
then
	REPLY="$( echo -ne "Yes(y)\nNo(n)" | dmenu -p "Create Mount Point?: " -fn "Fira Code-13")"
	if [ "$REPLY" = "Yes(y)" ]
	then
		eval "mkdir --parents "$SELECTED_MOUNT""
	else
		exit 1
	fi
elif [ $SELECTED_MOUNT = "[fstab]" ]
then
	sudo mount "/dev/$SELECTED_DRIVE"
	if [ $? -eq 0 ]
	then
		notify-send -a "USB-MOUNTER" "Mounted" "$SELECTED_DRIVE mounted as defined in fstab"
		exit 0
	else
		notify-send -a "USB-MOUNTER" "Failed" "$SELECTED_DRIVE is not defined in fstab" -u critical
		exit 0
	fi
fi

if echo $SELECTED_DRIVE | grep -q '^(MTP)'
then
	DEVICE_ID="$(simple-mtpfs -l | grep "$(echo "$SELECTED_DRIVE" | sed 's|-| |g' | sed 's|(MTP)||g')" | grep -o '^.*:')"
	echo $SELECTED_DRIVE
	simple-mtpfs --device "$DEVICE_ID" "$SELECTED_MOUNT"
else
	sudo mount "/dev/$SELECTED_DRIVE" "$SELECTED_MOUNT"
fi

if [ $? -eq 0 ]
then
	notify-send -a "USB-MOUNTER" "Mounted" "$SELECTED_DRIVE --> [$SELECTED_MOUNT]"
	exit 0
else
	notify-send -a "USB-MOUNTER" "Failed" "$SELECTED_DRIVE --> [$SELECTED_MOUNT]" -u critical
	exit 1
fi
