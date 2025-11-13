#!/bin/bash
source <(sed 's/ /\\ /' /sys/class/power_supply/BAT0/uevent)
if [[ -n $POWER_SUPPLY_CHARGE_FULL_DESIGN ]]; then
  echo $((100*POWER_SUPPLY_CHARGE_FULL/POWER_SUPPLY_CHARGE_FULL_DESIGN))%
elif [[ -n $POWER_SUPPLY_ENERGY_FULL_DESIGN ]]; then
  echo $((100*POWER_SUPPLY_ENERGY_FULL/POWER_SUPPLY_ENERGY_FULL_DESIGN))%
else
  echo "Couldn't figure out battery health!"
fi
