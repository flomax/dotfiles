#!/usr/bin/env bash

# Check that jq and swaymsg are installed
if ! command -v jq &> /dev/null || ! command -v swaymsg &> /dev/null; then
	echo "jq and swaymsg are required for this script to work!"
    exit 1
fi	

# Get the app_id of the currently focused window
APP=$(swaymsg -t get_tree | jq -r '.. | select(.focused == true)? | .app_id')

# Spawn alacritty with the correct cwd if it is currently focused, else spawn it at $HOME
if [[ $APP == Alacritty ]]; then
	PID=$(swaymsg -t get_tree | jq -r '.. | select(.focused == true)? | .pid')
	CWD=$(readlink -e /proc/$(ps -ef | awk -v pid="$PID" '$3==pid && $8=="/bin/zsh" {print $2}')/cwd)
	alacritty --working-directory=$CWD
else
	alacritty
fi
