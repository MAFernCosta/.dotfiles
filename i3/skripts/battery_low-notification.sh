#!/bin/bash
# Date: 04.02.26

set -u

notif=20

hiber=15

# Path for the internal battery it can be BAT0 or BAT1
BAT_PATH="/sys/class/power_supply/BAT0"

# In case BAT0 doesnt exits swap to BAT1
if [ ! -d "$BAT_PATH" ]; then
    BAT_PATH="/sys/class/power_supply/BAT1"
fi

percentage=$(cat "$BAT_PATH/capacity")
status=$(cat "$BAT_PATH/status")
if [ $status = 'Discharging' ] && [ $percentage -le $notif ] && [ $percentage -gt $hiber ]
then
    notify-send -u critical "Battery warning" "Battery at $percentage%. Connect the power adapter!"
elif [ $status = 'Discharging' ] && [ $percentage -le $hiber ]
then
    ID=9999
    for i in {60..1}; do
        dunstify -r $ID "Battery too low" "System will shutdown in $i seconds. Connect the power adapter to cancel this action." -u critical
        status=$(cat "$BAT_PATH/status")
        if [ $status = 'Charging' ]
        then
            dunstify -C $ID
            exit
        fi
        sleep 1
    done

    dunstify -r $ID "Shutdown warning" "Shutdown now"
    sleep 5
    systemctl suspend
fi


