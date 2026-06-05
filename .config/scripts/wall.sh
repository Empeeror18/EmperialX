#!/usr/bin/env bash

WALL="$1"

awww img "$WALL" \
  --transition-type wipe \
  --transition-angle 45 \
  --transition-duration 1 \
  --transition-fps 60

wal -i "$WALL"

killall waybar
waybar &
