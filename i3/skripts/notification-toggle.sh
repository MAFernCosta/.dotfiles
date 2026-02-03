#!/bin/bash
# Program: notification-toggle.sh
# Description: (Un)-Pauses the notifications
# Date: 03.02.2026
# Autor: Miguel

set -u

# Notifications lables
on=""
off=""
nr=""

# Store the current notification state
currentState=$(dunstctl is-paused)

case $currentState in
    true)
        echo "$off";;
    false)
        echo "$on";;
    *)
        echo "$nr";;
esac

# Toggle on left click
if [ "$BLOCK_BUTTON" = "1" ]; then
  dunstctl set-paused toggle
fi
