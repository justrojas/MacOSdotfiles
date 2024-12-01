#!/bin/bash
WINDOW_TITLE=$(/opt/homebrew/bin/yabai -m query --windows --window | jq -r ".title")
CURRENT_APP=$(/opt/homebrew/bin/yabai -m query --windows --window | jq -r ".app")

case "$CURRENT_APP" in
  "Firefox") ICON="􀎯";;
  "kitty") ICON="􀪏";;
  *) ICON="􀤆";;
esac

sketchybar --set "$NAME" icon="$ICON" label="$WINDOW_TITLE"
