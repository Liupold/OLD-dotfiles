#!/bin/sh

pactl list sinks | grep -q 'Active Port:.*-speaker' && echo ""
pactl list sinks | grep -q 'Active Port:.*-headphone' && echo ""

pactl subscribe | \
        grep --line-buffered -o "'change' on card" | \
        xargs -I{} -n1 pactl list sinks  | \
        grep --line-buffered  -o 'Active Port:.*-speaker' | \
        xargs -I{} -n1 echo "" &

pactl subscribe | \
        grep --line-buffered -o "'change' on card" | \
        xargs -I{} -n1 pactl list sinks  | \
        grep --line-buffered  -o 'Active Port:.*-headphone' | \
        xargs -I{} -n1 echo "" &

wait
