#!/bin/bash

# Labels
charging="Chr"
notCharging="Con"
disCharging="Dis"
unknown="?!?"

# Path for the internal battery it can be BAT0 or BAT1
BAT_PATH="/sys/class/power_supply/BAT0"

# In case BAT0 doesnt exits swap to BAT1
if [ ! -d "$BAT_PATH" ]; then
    BAT_PATH="/sys/class/power_supply/BAT1"
fi

percentage=$(cat "$BAT_PATH/capacity")
status=$(cat "$BAT_PATH/status")

curStatus="NR"

case $status in
    "Not charging")
        curStatus=$notCharging
        ;;
    "Full")
        curStatus=$notCharging
        ;;
    "Discharging")
        curStatus=$disCharging
        ;;
    "Charging")
        curStatus=$charging
        ;;
    *)
        curStatus="NR"
        ;;
esac

echo "$percentage% $curStatus"


