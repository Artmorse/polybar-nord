#!/usr/bin/env bash

# Toggle / display the xsct "yellow screen" (night mode) state.
# Usage: xsct-toggle.sh [status|toggle]

NIGHT_TEMP=3600
THRESHOLD=6000

current_temp() {
    # xsct only estimates the temperature, hence the threshold
    local t
    t=$(xsct 2>/dev/null | awk '/temperature/ {print $5; exit}')
    echo "${t:-6500}"
}

case "$1" in
    toggle)
        if [ "$(current_temp)" -lt "$THRESHOLD" ]; then
            xsct 0
        else
            xsct "$NIGHT_TEMP"
        fi
        ;;
    *)
        if [ "$(current_temp)" -lt "$THRESHOLD" ]; then
            echo "%{u#EBCB8B}%{+u}  %{F#EBCB8B}%{F-}  %{-u}"
        else
            echo "%{u#81A1C1}%{+u}  %{F#81A1C1}%{F-}  %{-u}"
        fi
        ;;
esac
