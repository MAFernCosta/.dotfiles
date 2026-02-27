#!/bin/bash
# Program: aut-display-set.sh
# Description: This Skript will scan for the DisplayLink usb device and when is connected change the display settings for multiple displays, when not change back to single display
# Date: 01.02.26
# Author: Miguel Costa

set -u

### The display Settings goes here
# Mulimonitor
multiMonitor="xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --off --output DP-2 --mode 1920x1080 --pos 4480x360 --rotate normal --output DVI-I-4-4 --off --output DVI-I-3-3 --off --output DVI-I-1-1 --primary --mode 2560x1440 --pos 1920x0 --rotate normal --output DVI-I-2-2 --mode 1920x1200 --pos 0x240 --rotate normal"
# Single monitor
oneMonitor="xrandr --output DP-0 --off --output DP-1 --off --output HDMI-0 --off --output DP-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DVI-I-4-4 --off --output DVI-I-3-3 --off --output DVI-I-1-1 --off --output DVI-I-2-2 --off"


# The name of the device to trigger the display config
usbToSearch="DisplayLink Dell Universal Dock D6000"

# Search for device and return the number of lines that the command outputs
command=$(lsusb | grep "$usbToSearch" | cut -d ':' -f 3 | wc -l)

echo "$command"

if [[ $command -ge 1 ]]
then
    echo "Connected to $usbToSearch"
    $multiMonitor
else
    echo "Single Monitor"
    $oneMonitor
fi
