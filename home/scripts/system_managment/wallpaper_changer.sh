#!/bin/sh
REL_WALL_PATH=$1
WALL_PATH=$(realpath $REL_WALL_PATH)

wal -a 85 -i "$WALL_PATH"
echo "$WALL_PATH" > "$HOME/.config/WALL_PATH"



