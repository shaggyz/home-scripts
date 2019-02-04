#!/usr/bin/env bash

USED_SPACE=$(df -h | grep '/$' | awk '{print $3}')
USED_PERCENT=$(df -h | grep '/$' | awk '{print $5}')
FREE_SPACE=$(df -h | grep '/$' | awk '{print $4}')
TOTAL_SPACE=$(df -h | grep '/$' | awk '{print $2}')

# echo "$USED_SPACE ($USED_PERCENT) / $FREE_SPACE / $TOTAL_SPACE"
echo "$USED_PERCENT - $USED_SPACE / $FREE_SPACE"
