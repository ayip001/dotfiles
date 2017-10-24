#!/bin/bash

# github.com/ayip001
# ~/.bash_profile
#
# This loads automatically upon login.

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ "$(tty)" = "/dev/tty1" ]; then
	startx && exit
fi
