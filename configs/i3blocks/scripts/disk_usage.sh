#!/usr/bin/env bash

USED_SPACE=$(df -h | grep '/$' | cut -d' ' -f11)
FREE_SPACE=$(df -h | grep '/$' | cut -d' ' -f13)
TOTAL_SPACE=$(df -h | grep '/$' | cut -d' ' -f8)

echo "$USED_SPACE / $FREE_SPACE / $TOTAL_SPACE"

