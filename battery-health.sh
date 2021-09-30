#!/bin/bash
source <(sed 's/ /\\ /' /sys/class/power_supply/BAT0/uevent)
echo $((100*POWER_SUPPLY_CHARGE_FULL/POWER_SUPPLY_CHARGE_FULL_DESIGN))%
