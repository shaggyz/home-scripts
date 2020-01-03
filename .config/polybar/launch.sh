#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $(id -u) -x polybar >/dev/null; do sleep 1; done

# Launch linux bar
echo "---" | tee -a /tmp/polybar1.log 
polybar linux  >>/tmp/polybar1.log 2>&1 &
