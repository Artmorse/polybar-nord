#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bars
if type "xrandr"; then

	monitors=`xrandr --listmonitors | tail -n +2 | awk -F'\\ \\ ' '{print $NF}'`
	len_monitors=`xrandr --listmonitors | head -n 1 | awk -F'\\ ' '{print $NF}'`

	echo "${len_monitors} monitor(s) detected"

	if [ $((len_monitors)) -eq 2 ]; then
		monitor_1=`xrandr --listmonitors | tail -n +2 | awk -F'\\ \\ ' '{print $NF}' | head -1 | tail -1`
		monitor_2=`xrandr --listmonitors | tail -n +2 | awk -F'\\ \\ ' '{print $NF}' | head -2 | tail -1`
		MONITOR=$monitor_2 polybar -c $HOME/.config/polybar/bars-config nord-top &
		echo "The top bar has been launched on the second monitor."
		MONITOR=$monitor_1 polybar -c $HOME/.config/polybar/bars-config nord-down &
		echo "The down bar has been launched on the primary monitor."
		MONITOR=$monitor_1 polybar -c $HOME/.config/polybar/bars-config nord-top-2 &
		echo "The second top bar has been launched on the primary monitor."
	else
		for m in $monitors; do
			MONITOR=$m polybar -c $HOME/.config/polybar/bars-config nord-top &
			MONITOR=$m polybar -c $HOME/.config/polybar/bars-config nord-down &
		done
		echo "Bars launched on each monitor."
	fi
else
	echo "xrandr not found..."
	exit 1
fi

