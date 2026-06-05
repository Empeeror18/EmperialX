#!/bin/bash

WALL_DIR="$HOME/Pictures/wallpapers"

# Start awww daemon if not running
if ! pidof awww-daemon >/dev/null; then
  awww-daemon &
  sleep 0.5
fi

SELECTED=$(
  for img in "$WALL_DIR"/*; do
    [[ "$img" =~ \.(jpg|jpeg|png|webp|JPG|PNG)$ ]] || continue

    printf "%s\0icon\x1f%s\n" "$(basename "$img")" "$img"
  done | rofi \
    -dmenu \
    -i \
    -show-icons \
    -theme ~/.config/rofi/themes/wallpaper.rasi \
    -p ""
)

if [ -n "$SELECTED" ]; then

  TRANSITIONS=("wipe" "grow")
  TRANSITION=${TRANSITIONS[$RANDOM % ${#TRANSITIONS[@]}]}

  if [ "$TRANSITION" = "grow" ]; then

    # screen fallback (safe default)
    WIDTH=1920
    HEIGHT=1080

    # random position
    X=$((RANDOM % WIDTH))
    Y=$((RANDOM % HEIGHT))

    awww img "$WALL_DIR/$SELECTED" \
      --transition-type grow \
      --transition-pos "$X,$Y" \
      --transition-duration 1 \
      --transition-fps 60 \
      --transition-step 90

  else

    awww img "$WALL_DIR/$SELECTED" \
      --transition-type wipe \
      --transition-duration 1 \
      --transition-fps 60 \
      --transition-step 90

  fi
  wal -i "$HOME/Pictures/wallpapers/$SELECTED"
  pkill -USR2 waybar
fi
