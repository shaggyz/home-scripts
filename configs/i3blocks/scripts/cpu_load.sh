#!/usr/bin/env bash

AVG_LOAD=$(uptime | awk '{print $8+0}')
CORES=$(grep processor /proc/cpuinfo | wc -l)

echo "$AVG_LOAD / $CORES.00"

