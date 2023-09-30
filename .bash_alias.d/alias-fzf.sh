#!/usr/bin/bash

if command -v fzf > /dev/null; then
	alias cdf='cd $(find * -type d | fzf)'
	alias vif='vim $(fzf)'
fi
