#!/bin/bash
searchType="$1"
searchTerm="$2"
for file in $(ls /usr/share/icons/*/{*/"$searchType"/*"$searchTerm"*,"$searchType"/*/*"$searchTerm"*} 2>/dev/null); do
  name=${file%.*}
  name=${name##*/}
  found=false
  for mem in "${names[@]}"; do
    [ "$mem" = "$name" ] && found=true
  done
  if [ $found = false ]; then
    echo $name
    names=(${names[@]} $name)
  fi
done
