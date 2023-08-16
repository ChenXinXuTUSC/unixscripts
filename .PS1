#!/usr/bin/env bash

function parse_git_branch()
{
  	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

function have_changes()
{
	[ -n "$(git status 2> /dev/null | grep Changes)" ] && echo "[x]"
}

if [ "$color_prompt" = yes ]; then
	if [ -x "$(command -v git)" ]; then
		PS1='┌[${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \t\[\033[00m\]] \[\033[01;34m\]\w\[\033[00m\]\[\033[01;32m\]$(parse_git_branch)\[\033[00m\]\[\033[01;33m\]$(have_changes)\[\033[00m\]\n└\$ '
	else
    	PS1='┌[${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h \t\[\033[00m\]] \[\033[01;34m\]\w\[\033[00m\]\n└\$ '
	fi
else
	if [ -x "$(command -v git)" ]; then
    	PS1='┌[${debian_chroot:+($debian_chroot)}\u@\h \t] \w$(parse_git_branch)$(have_changes)\n└\$ '
	else
		PS1='┌[${debian_chroot:+($debian_chroot)}\u@\h \t] \w\n└\$ '
	fi
fi

