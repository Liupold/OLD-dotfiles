DRIVES="$(lsblk | grep -v 'sda' | grep -o 'sd.*$' | grep -o '.*part $' | awk '{ print $1 " ("$4")" }')"
MOUNT_POINT="/mnt\n/home/rohnch/USB\n[fstab]"

SELECTED_DRIVE="$(echo "$DRIVES" | dmenu -p "Mount?: " -fn "Fira Code-13" | awk '{ print $1 }')"

if [ -z $SELECTED_DRIVE ]
then
	exit 0
fi

SELECTED_MOUNT="$(echo -ne "$MOUNT_POINT" | dmenu -p "Mount Point: " -fn "Fira Code-13")"

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

sudo mount "/dev/$SELECTED_DRIVE" "$SELECTED_MOUNT"
if [ $? -eq 0 ]
then
	notify-send -a "USB-MOUNTER" "Mounted" "$SELECTED_DRIVE --> [$SELECTED_MOUNT]"
	exit 0
else
	notify-send -a "USB-MOUNTER" "Failed" "$SELECTED_DRIVE --> [$SELECTED_MOUNT]"
	exit 1
fi
