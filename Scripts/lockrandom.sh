#!/bin/bash

# github.com/ayip001 ~/Script/lockrandom.sh
#
# It looks at the ~/Pictures directory
# and randomly selects a file which name contains 'lock'
# Then call i3lock on that file.
# So make sure everything that contains 'lock' in ~/Pictures
# is a .png file of your exact screen resolution

FILENAME=$(ls ~/Pictures | grep lock | sort -R | head -n 1)

i3lock -u -e -i ~/Pictures/$FILENAME
