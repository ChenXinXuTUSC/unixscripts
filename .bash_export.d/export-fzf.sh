#!/bin/bash

if command -v fzf > /dev/null; then
	export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --preview '(highlight -O ansi {} || cat {}) 2> /dev/null | head -500'"
fi
