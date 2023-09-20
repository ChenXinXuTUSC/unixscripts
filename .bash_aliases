#!/usr/bin/env bash

alias pscpu='ps -aux | sort -k3nr | head -10'
alias psmem='ps -aux | sort -k4nr | head -10'
alias ls='ls -lFh --color=auto'
alias ll='ls -alFh --color=auto'
alias lsp='ls | grep'
alias llp='ll | grep'
alias pp='ps -aux | grep -v grep | grep'
alias duone='du --max-depth=1 -BM'
alias sss='sudo ss -tnlp'
alias stl='sudo systemctl'
alias ssp='sudo ss -tnlp | grep'
alias rebashrc='cd && source .bashrc && cd -'

if command -v fzf > /dev/null; then
	alias cdf='cd $(find * -type d | fzf)'
	alias vif='vim $(fzf)'
fi

if command -v clash > /dev/null; then
	alias clashon='source clashon.sh'
	alias clashoff='source clashoff.sh'
fi

if command -v nvidia-smi > /dev/null; then
    alias nsi='nvidia-smi'
fi
