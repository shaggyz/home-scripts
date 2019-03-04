#!/usr/bin/env bash
LEVEL=$(amixer get Master | grep '\[on\]' | head -1 | cut -d'[' -f2 | cut -d']' -f1 | sed s/%//g)

# Button actions
case $BLOCK_BUTTON in
	# Right click: Toggle mute.
    3) amixer -q set Master toggle;;
	# Sroll up: increase level
    4) amixer -q set Master 5%+;;
	# Sroll down: decrease level
    5) amixer -q set Master 5%-;;
esac

# Muted icon
if amixer get Master | grep -q '\[off'; then
	echo " $LEVEL%"
	exit 0
fi

# Level below to 50%
if [ "$LEVEL" -lt "50" ]; then
	echo " $LEVEL%"
	exit 0
fi

# Display volume level, more than 50%
echo " $LEVEL%"
exit 0
