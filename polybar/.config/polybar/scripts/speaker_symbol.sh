#!/bin/sh
sinks="$(pactl list sinks)"
[ "${sinks#*Active Port:*-speaker}" != "$sinks" ] && echo ""
[ "${sinks#*Active Port:*-headphone}" != "$sinks" ]  && echo ""
pactl subscribe | while read -r event; do
        [ "${event#*\'change\' on card}" != "$event" ] &&
                sinks="$(pactl list sinks)"
                [ "${sinks#*Active Port:*-speaker}" != "$sinks" ] && echo ""
                [ "${sinks#*Active Port:*-headphone}" != "$sinks" ] && echo ""
done
