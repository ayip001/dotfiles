#!/bin/bash

# github.com/ayip001
# ~/bin/gitswapremote.sh
# 
# When you clone from Github, the remote URL is http.
# Run this to swap the remote URL from HTTP to SSH

if (($(git remote -v | grep -c http)))
then # HTTP
	FROM="HTTP"
	TO="SSH"
	NUM=27
	PROTO="git@github.com:"
else # SSH
	FROM="SSH"
	TO="HTTP"
	NUM=23
	PROTO="https://github.com/"
fi

UR=$(git remote -v | sed '1q;d' | cut -c$NUM- | rev | cut -c9- | rev)
URL=$PROTO$UR
echo "Current: $FROM, changing to: $TO"
echo "New URL: $URL"

# if the URL doesn't end with .git, fix it
if [[ ! $URL =~ \.git$ ]]
then
	URL=$URL".git"
fi

git remote set-url origin $URL
echo
echo "$ git remote -v"
git remote -v
