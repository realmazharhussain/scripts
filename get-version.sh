#!/bin/bash
first=1636200000
first=($(git rev-list --reverse --format=format:%ct HEAD | grep -v commit))
last=$(git rev-list --format=format:%ct HEAD -1 | grep -v commit)
diff=$((last - first))
pico=$((diff % 100000))
micro=$(( (diff/100000) % 100))
sub=$(( (diff/100000/100) % 20))
main=$((1+ diff/100000/100/20))
echo $diff
echo $main.$sub.$micro-$pico
