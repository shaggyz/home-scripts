#!/usr/bin/env bash

#------------------------------------------------------------------------
INTERFACE="wlp3s0"
#------------------------------------------------------------------------

[[ ! -d /sys/class/net/${INTERFACE}/wireless ]] && exit

if [[ "$(cat /sys/class/net/$INTERFACE/operstate)" = 'down' ]]; then
    echo "down"
    echo "down"
    echo "#FF0000"
    exit
fi

#------------------------------------------------------------------------
QUALITY=$(grep $INTERFACE /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')
#------------------------------------------------------------------------

echo $QUALITY% # full text
echo $QUALITY% # short text

# color
if [[ $QUALITY -ge 80 ]]; then
    echo "#00FF00"
elif [[ $QUALITY -ge 60 ]]; then
    echo "#FFF600"
elif [[ $QUALITY -ge 40 ]]; then
    echo "#FFAE00"
else
    echo "#FF0000"
fi
