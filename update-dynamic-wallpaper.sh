#!/bin/bash
xmlFile=/usr/share/backgrounds/my-dynamic.xml

echo "<background>
 <starttime>
  <year>2021</year>
  <month>8</month>
  <day>6</day>
  <hour>0</hour>
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
done <<<$(ls -dtr1 $HOME/Pictures/Wallpapers/*)


echo "</background>" | sudo tee -a "$xmlFile" > /dev/null
