#!/bin/bash

# github.com/ayip001 ~/bin/bgswp.sh
#
# I have a bunch of named backgrounds named ~/Pictures/bg$NUM
# ~/.config/i3/config sets background to ~/Pictures/bg by default
# So if I want to set bg4 at the active background, bg4 and bg gets swapped
# bgswp.sh 4

FILENAME=~/Pictures/bg$1

if [ -e $FILENAME ]; then
	echo "swapping"
	mv ~/Pictures/bg /tmp/bgbuffer
	mv $FILENAME ~/Pictures/bg
	mv /tmp/bgbuffer $FILENAME
	echo "swapped"
	exit 0
fi
echo "nothing found"
exit 1
