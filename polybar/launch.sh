#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/dotfiles/polybar/colorblocks"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch the bar
if [[ $(bspc query -M --names) = "HDMI-A-0" ]]; then
	polybar -q jimmyBar -c "$DIR"/config.ini &
else 
	polybar -q jimmyBar -c "$DIR"/configDualMonitors.ini &
fi
