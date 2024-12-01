#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

case "$SENDER" in
"mouse.clicked")
	# The click_script in the items file will handle the space switching
	;;
*)
	if [ $SELECTED = true ]; then
		sketchybar --set $NAME background.drawing=on \
			background.color=$BACKGROUND_1 \
			label.color=$LABEL_COLOR \
			icon.color=$BLUE
	else
		sketchybar --set $NAME background.drawing=off \
			label.color=$LABEL_COLOR \
			icon.color=$BLUE
	fi
	;;
esac
