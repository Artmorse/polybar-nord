#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bars
if type "xrandr"; then

    is_primary=1

    while [[ $# -gt 0 ]]; do
        m=$1
        if [ $is_primary -eq 1 ]; then
            MONITOR="$m" polybar -c $HOME/.config/polybar/bars-config nord-top &
            MONITOR="$m" polybar -c $HOME/.config/polybar/bars-config nord-down &
            echo "The nord-top bar and the nord-down bar has been launched on the $m monitor (primary)."
            is_primary=0
        else
            MONITOR="$m" polybar -c $HOME/.config/polybar/bars-config little-nord-top &
            echo "The little nord-top bar has been launched on the $m monitor."
        fi
        shift
    done
else
	echo "xrandr not found..."
	exit 1
fi
