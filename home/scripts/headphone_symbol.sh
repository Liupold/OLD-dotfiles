#!/bin/bash

sink_id=0
event_acpi_listen=`acpi_listen -c 1`
port_name_headset="analog-output-headphones"
port_name_speaker="analog-output-speaker"
cur_port=`pactl list sinks | awk '/Active Port:/ { print $3 }'`
if [ "$cur_port" == "$port_name_speaker" ]
then
    echo ""
fi
if [ "$cur_port" == "$port_name_headset" ]
then
    echo ""
fi
