#!/bin/bash

XDG_PICTURES_DIR=$(xdg-user-dir PICTURES)

if [[ -z $XDG_PICTURES_DIR ]]; then
  echo "Could not detect PICTURES directory!" >&2
  exit 1
elif [[ ! -d "$XDG_PICTURES_DIR"/Wallpapers ]]; then
  echo "PICTURES/Wallpapers directory does not exist!" >&2
  exit 1
elif [[ -z $(ls "$XDG_PICTURES_DIR"/Wallpapers) ]]; then
  echo "There are no wallpapers to create a dynamic wallpaper out of" >&2
  exit 1
fi

xmlFile=/usr/share/backgrounds/my-dynamic.xml

echo "<background>
 <starttime>
  <year>2021</year>
  <month>9</month>
  <day>5</day>
  <hour>7</hour>
  <minute>0</minute>
  <second>0</second>
 </starttime>
" | sudo tee "$xmlFile" > /dev/null

echo -n '<?xml version="1.0"?>
<!DOCTYPE wallpapers SYSTEM "gnome-wp-list.dtd">
<wallpapers>
  <wallpaper deleted="false">
    <name>MyDynamic</name>
    <filename>/usr/share/backgrounds/my-dynamic.xml</filename>
    <options>zoom</options>
    <shade_type>solid</shade_type>
    <pcolor>#3465a4</pcolor>
    <scolor>#000000</scolor>
  </wallpaper>
</wallpapers>
' | sudo tee /usr/share/gnome-background-properties/MyDynamic.xml >/dev/null

while read wallpaper; do
  if file --brief --mime-type "$wallpaper" | grep 'image/' &>/dev/null; then
#    if [ -n "$prevWallpaper" ]; then
#      echo "
#        <transition type="overlay">
#                <duration>2.0</duration>
#                <from>$prevWallpaper</from>
#                <to>$wallpaper</to>
#        </transition>
#" >> ~/Pictures/Wallpapers/dynamic-all.xml
#    fi
#    prevWallpaper="$wallpaper"

# duration:
#   86400 1day

    echo "
 <static>
  <duration>86400.0</duration>
  <file>$wallpaper</file>
 </static>
" | sudo tee -a "$xmlFile" > /dev/null
  fi
done <<<$(ls -dtr1 "$XDG_PICTURES_DIR"/Wallpapers/*)


echo "</background>" | sudo tee -a "$xmlFile" > /dev/null
