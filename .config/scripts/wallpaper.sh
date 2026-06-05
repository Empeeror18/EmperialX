#!/bin/bash

WALLDIR="$HOME/Pictures/wallpapers"
WALL=$(find "$WALLDIR" -type f | shuf -n 1)

awww img "$WALL" --transition-type wipe --transition-duration 1 --transition-fps 144 --transition-step 255
