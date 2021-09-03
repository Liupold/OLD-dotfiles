#!/bin/sh
DATA="$@"
DATAX="$@"

DATA="${DATA##*status }"
status="${DATA%% file*}"

DATA="${DATA##*artist }"
artist="${DATA%% title*}"
artist="${artist%% album*}"

DATA="${DATA##*title }"
title="${DATA%% date*}"

[ "$status" = "playing" ] && status=">"
[ "$status" = "paused" ] && status="|"
[ "$status" = "stopped" ] && status="."

[ "$title" = "$artist" ] && artist=""  && title="file: \"${DATA#*file }\""

echo "CMUS:[ $status $title ($artist) ]" > /tmp/dwmbar
