#!/usr/bin/env bash
# Count available system updates for Arch Linux
# Combines pacman and AUR (yay) updates
# Requires: pacman-contrib (for checkupdates), yay

if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
fi

if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
    updates_aur=0
fi

updates=$((updates_arch + updates_aur))

echo "$updates"
