#!/bin/bash

# Labels
charging="Chr"
notCharging="Con"
disCharging="Dis"
unknown="?!?"

percentage=$(acpi -b | grep "Battery 0" | cut -d ":" -f 2 | cut -d "," -f 2)
status=$(acpi -b | grep "Battery 0" | cut -d ":" -f 2 | cut -d "," -f 1)
curStatus="NR"

case $status in 
    " Not charging")
        curStatus=$notCharging
        ;;
    " Discharging")
        curStatus=$disCharging
        ;;
    " Charging")
        curStatus=$charging
        ;;
    *)
        curStatus="NR"
        ;;
esac

echo "$percentage $curStatus"

