
#!/bin/bash

WALL=$(find ~/Pictures/wallpapers -type f | shuf -n 1)

awww img "$WALL" \
  --transition-type wipe \
  --transition-angle 45 \
  --transition-step 90 \
  --transition-fps 60 \
  --transition-duration 1

wal -i "$WALL"

pkill waybar
waybar &
