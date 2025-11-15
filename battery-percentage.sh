#!/bin/bash
source <(sed 's/ /\\ /' /sys/class/power_supply/BAT0/uevent)

if [[ -n $POWER_SUPPLY_CHARGE_FULL ]]; then
  echo $((100*POWER_SUPPLY_CHARGE_NOW/POWER_SUPPLY_CHARGE_FULL))%
elif [[ -n $POWER_SUPPLY_ENERGY_FULL_DESIGN ]]; then
  echo $((100*POWER_SUPPLY_ENERGY_NOW/POWER_SUPPLY_ENERGY_FULL))%
else
  echo "Couldn't figure out battery percentage!"
fi
