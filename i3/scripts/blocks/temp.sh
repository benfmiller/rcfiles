#!/bin/bash

# intelTemp=$(sensors | # execute sensors
# grep -w "Core 0:" | # grep for the first core
# sed 's/([^)]*)//g' | # filter
# tr -s " " | # remove whitespace
# sed -e 's/Core 0\(.*\):/\1/' | #  get value between Core 0 and :
# cut -c 3- | rev | cut -c 7- | rev #remove clutter
# )
intelTemp=$(sensors | grep -w -B 1 "Core 0:" | head -n 1 | sed 's/([^)]*)//g' | tr -s " " | rev | cut -f1 -d":" | rev)

amdTemp=$(sensors | grep -w "Tdie:" | sed 's/([^)]*)//g' | tr -s " " | cut -c 8- | rev | cut -c 6- | rev)

# echo out the result
if [ -z "$intelTemp" ]
then
      echo $amdTemp
else
      echo $intelTemp
fi
