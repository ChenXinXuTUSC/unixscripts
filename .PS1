#!/usr/bin/env bash

function parse_git_branch()
{
	if [ -x $(command -v git) ]; then
  		git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
	fi
}

function have_changes()
{
	[ -n "$(git status 2> /dev/null | grep 'Changes\|变更\|Untracked')" ] && echo "[x]"
}

# some bash font control sequence
# code of effects
#	 FX_RST - \033[00m - reset to default
#	 FX_BLD - \033[01m - bold font
#	 FX_DRK - \033[02m - darken the colour
#	 FX_UDL - \033[04m - underlined
#	 FX_BLK - \033[05m - blink
#	 FX_REV - \033[07m - revert
#	 FX_HDN - \033[08m - hidden
# code of front colours
#	 CF_BLK - \033[30m
#	 CF_RED - \033[31m
#	 CF_GRN - \033[32m
#	 CF_YLW - \033[33m
#	 CF_BLE - \033[34m
#	 CF_PRP - \033[35m
#	 CF_CYN - \033[36m
#	 CF_WHE - \033[37m
# code of back colours
#	 CB_BLK - \033[40m
#	 CB_RED - \033[41m
#	 CB_GRN - \033[42m
#	 CB_YLW - \033[43m
#	 CB_BLE - \033[44m
#	 CB_PRP - \033[45m
#	 CB_CYN - \033[46m
#	 CB_WHE - \033[47m


FX_RST="\e[00m"
FX_BLD="\e[01m"
FX_DRK="\e[02m"
FX_UDL="\e[04m"
FX_BLK="\e[05m"
FX_REV="\e[07m"
FX_HDN="\e[08m"

CF_BLK="\e[30m"
CF_RED="\e[31m"
CF_GRN="\e[32m"
CF_YLW="\e[33m"
CF_BLE="\e[34m"
CF_PRP="\e[35m"
CF_CYN="\e[36m"
CF_WHE="\e[37m"
CF_ORG="\e[39m"

CB_BLK="\e[40m"
CB_RED="\e[41m"
CB_GRN="\e[42m"
CB_YLW="\e[43m"
CB_BLE="\e[44m"
CB_PRP="\e[45m"
CB_CYN="\e[46m"
CB_WHE="\e[47m"
CB_ORG="\e[49m"

function fx_clr()
{
	# $1 - str to format
	# $2 - font effect
	# $3 - font front colour
	# $4 - font back colour

	# but as these control codes have different
	# range, the order of these codes  are  not
	# fixed

	a=1
}

if [ "$color_prompt" = yes ]; then
	PS1='┌[${debian_chroot:+($debian_chroot)}\e[01;32m\u@\h \t\e[00m] \e[07m\e[01m\e[34m\w\e[00m\e[01;32m$(parse_git_branch)\e[05m\e[01;33m$(have_changes)\e[00m\n└> '
else
    PS1='┌[${debian_chroot:+($debian_chroot)}\u@\h \t] \w$(parse_git_branch)$(have_changes)\n└\$ '
fi

