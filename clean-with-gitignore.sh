#!/bin/bash
if test ! -f .gitignore;
then
   echo "'.gitignore' file not found" >&2
   exit 1
fi
while read line;
do
   line=$(echo "$line" | sed -E 's/(#.*)|(^[[:space:]]*$)|^\///g')
   eval files=($line)
   if [[ "$line" != '' ]] && [[ "${files[*]}" != *\** ]]
   then
      for file in "${files[@]}"
      do
         rm -rf "$file"
      done
   fi
done < .gitignore
