#
# ~/.bash_profile
#

# github.com/ayip001
# This loads automatically upon login.

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ "$(tty)" = "/dev/tty1" ]; then
	startx && exit
fi
