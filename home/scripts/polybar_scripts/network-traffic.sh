#!/bin/bash

print_bytes() {
    if [ "$1" -eq 0 ] || [ "$1" -lt 1000 ]; then
        bytes="0 kB/s"
    elif [ "$1" -lt 1000000 ]; then
        bytes="$(echo "scale=0;$1/1000" | bc -l ) kB/s"
    else
        bytes="$(echo "scale=1;$1/1000000" | bc -l ) MB/s"
    fi

    echo "$bytes"
}

print_bit() {
    if [ "$1" -eq 0 ] || [ "$1" -lt 10 ]; then
        bit="0 B"
    elif [ "$1" -lt 100 ]; then
        bit="$(echo "scale=0;$1*8" | bc -l ) B"
    elif [ "$1" -lt 100000 ]; then
        bit="$(echo "scale=0;$1*8/1000" | bc -l ) K"
    else
        bit="$(echo "scale=1;$1*8/1000000" | bc -l ) M"
    fi

    echo "$bit"
}

INTERVAL=1
DOWN_THRESHOLD=1000 # in bytes
UP_THRESHOLD=1000 # in bytes
INTERFACES="$(ifconfig -a | grep -v lo | awk '/RUNNING/ { gsub(":", ""); print $1 }')"
iszero=""
while [ 1 ]; do
    down=0
    up=0

    if [ -n "$INTERFACES" ]
    then
    	for interface in $INTERFACES; do
		if [ ! -e "/sys/class/net/$interface/" ]
		then
		    INTERFACES="$(ifconfig -a | grep -v lo | awk '/RUNNING/ { gsub(":", ""); print $1 }')"
		    break
		fi

        	initial_rx=$(< /sys/class/net/"$interface"/statistics/rx_bytes)
		initial_tx=$(< /sys/class/net/"$interface"/statistics/tx_bytes)

		sleep $INTERVAL

		final_rx=$(< /sys/class/net/"$interface"/statistics/rx_bytes)
		final_tx=$(< /sys/class/net/"$interface"/statistics/tx_bytes)

		bytes_down=$(($final_rx - $initial_rx / $INTERVAL))
		bytes_up=$(($final_tx - $initial_tx  / $INTERVAL))

		down=$(( $down + $bytes_down ))
		up=$(( $up + $bytes_up ))

    	done

	if [ $down -gt $DOWN_THRESHOLD ] || [ $up -gt $UP_THRESHOLD ]
    	then
    		# echo "Download: $(print_bytes $down) / Upload: $(print_bytes $up)"
    		# echo "Download: $(print_bit $down) / Upload: $(print_bit $up)"
		echo " $(print_bytes $down)  $(print_bytes $up)"
		iszero=""
    	elif [ -z $iszero ]
    	then
	    # echo "Download: $(print_bytes $down) / Upload: $(print_bytes $up)"
    	    # echo "Download: $(print_bit $down) / Upload: $(print_bit $up)"
	    echo " $(print_bytes $down)  $(print_bytes $up)"
	    iszero="1"
   	 fi
    else
	 sleep $INTERVAL
	 INTERFACES="$(ifconfig -a | grep -v lo | awk '/RUNNING/ { gsub(":", ""); print $1 }')"

    fi

done
