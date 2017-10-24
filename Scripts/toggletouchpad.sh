#!/bin/bash

# github.com/ayip001
# ~/Scripts/toggletouchpad.sh
# 
# it toggles the touchpad
# what a surprise

if synclient -l | grep "TouchpadOff .*=.*0" ; then
    synclient TouchpadOff=1 ;
else
    synclient TouchpadOff=0 ;
fi
