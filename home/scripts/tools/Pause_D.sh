#!/bin/sh
while [ 1 ]
do
    [ "$(acpi_listen -c 1)" = "jack/headphone HEADPHONE unplug" ] && playerctl -a pause
done