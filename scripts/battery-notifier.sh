#!/bin/bash

# Battery threshold (change as needed)
THRESHOLD=30
CRITICAL_THRESHOLD=10

# Get battery percentage
BATTERY_LEVEL=$(acpi -b | grep -P -o '[0-9]+(?=%)')

# Check if the battery is discharging
BATTERY_STATUS=$(acpi -b | grep -o "Discharging")

if [[ "$BATTERY_STATUS" == "Discharging" ]]; then
    if [[ $BATTERY_LEVEL -le $CRITICAL_THRESHOLD ]]; then
        notify-send -u critical "Battery Critically Low" "Battery is at $BATTERY_LEVEL%!" -i battery-caution
    elif [[ $BATTERY_LEVEL -le $THRESHOLD ]]; then
        notify-send -u normal "Battery Low" "Battery is at $BATTERY_LEVEL%." -i battery-low
    fi
fi
