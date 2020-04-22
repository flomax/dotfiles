#!/usr/bin/env sh

# Terminate already running bar instances
killall -q swaybar

# Wait until the processes have been shut down
while pgrep -x swaybar >/dev/null; do sleep 1; done

# Launch main
swaybar
