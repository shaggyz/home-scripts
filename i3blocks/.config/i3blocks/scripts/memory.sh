#!/usr/bin/env bash

USED=$(free -h | grep Mem: | cut -d' ' -f21)
TOTAL=$(free -h | grep Mem: | cut -d' ' -f13)

echo "$USED / $TOTAL"
