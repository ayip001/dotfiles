# github.com/ayip001 ~/.bashrc
#
# default bash settings, what more can I say

# If not running interactively, do nothing
[[ $- != *i* ]] && return

# cycle through options with tab completion
# [[ $- = *i* ]] && bind TAB:menu-complete
bind "TAB:menu-complete"
bind "set show-all-if-ambiguous on"
bind "set menu-complete-display-prefix on"

PATH=~/bin:$PATH

# HiDPI: This following line is used during setup out of a window manager
# setfont ter-v32n

# This draws the ascii Transistor o=||[(\u)\h]]}) [\w]\n\\$
export PS1="\[\e[33m\]o=\[\e[m\]\[\e[31m\]||\[\e[m\]\[\e[36m\]>\[\e[31m\](\u)\[\e[m\]\[\e[36m\]\h]]\[\e[m\]\[\e[33m\]}) \[\e[m\][\w]\n\\$\[\e[m\] "

newalias ()
{
	echo "alias "$1"='"$2"'" >> ~/.bashrc
}

# aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias weather='curl http://wttr.in/94134?m' # get rid of ?m for freedom units
alias wifihome='sudo netctl stop-all; sudo netctl start wlp2s0-Lotsoland'
alias wifischool='sudo netctl stop-all; sudo netctl start wlp2s0-42US\ Student'
alias xclip='xclip -selection c'
