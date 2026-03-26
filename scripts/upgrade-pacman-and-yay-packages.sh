#!/usr/bin/env bash
# Upgrade system packages using yay and pacman
# This script is typically triggered from the polybar updates module
# Requires: yay, pacman

yay -Suy --noconfirm
sudo pacman -Suy --noconfirm
