#!/bin/sh
REL_WALL_PATH=$1
set -e

if [ -z "$REL_WALL_PATH" ]
then

	WALL_PATH="$(< "$HOME/.config/WALL_PATH")"

else
	WALL_PATH=$(realpath $REL_WALL_PATH)
	echo "$WALL_PATH" > "$HOME/.config/WALL_PATH"
fi

wal -a 85 -i "$WALL_PATH"