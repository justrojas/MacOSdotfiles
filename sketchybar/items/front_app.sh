#!/bin/bash
sketchybar --add item front_app left \
           --set front_app \
                script="$PLUGIN_DIR/front_app.sh" \
                icon.font="SF Pro:Bold:14.0" \
                label.font="SF Pro:Regular:13.0" \
                icon.color=0xffffffff \
                label.color=0xffffffff \
           --subscribe front_app front_app_switched
