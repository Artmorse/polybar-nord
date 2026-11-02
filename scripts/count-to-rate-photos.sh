#!/usr/bin/env bash
# Count the LeMorse photos (JPG) still waiting to be rated
# Prints nothing when the drive is not mounted, so polybar hides the module

TO_RATE_DIR="/media/acaron/X10 Pro/LeMorsePhotos3/02 - TO_RATE"

if [ ! -d "$TO_RATE_DIR" ]; then
    echo ""
    exit 0
fi

find "$TO_RATE_DIR" -path '*/*.JPG' -type f 2>/dev/null | wc -l
