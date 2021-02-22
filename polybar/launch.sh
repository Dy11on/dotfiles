#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
polybar-msg cmd quit

# Launch jimmyBar and bar2
echo "---" | tee -a /tmp/polyjimmyBar.log 
polybar jimmyBar 2>&1 | tee -a /tmp/polyjimmyBar.log & disown

echo "Bars launched..."
