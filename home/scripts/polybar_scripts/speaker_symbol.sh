
while [ 1 ]
do
	SPEAKER=$(pactl list sinks | awk '/Active Port:/ { print $3 }')
	if [ "$SPEAKER" = "analog-output-headphones" ]
	then
		echo ""
	elif [ "$SPEAKER" = "analog-output-speaker" ]
	then
		echo ""
	fi
	acpi_listen -c 1 > /dev/null
done
