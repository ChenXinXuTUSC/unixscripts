#!/usr/bin/env bash

if command -v docker > /dev/null; then
    # alias docker='dck'
    alias dckimg='docker image ls'
    alias dckctn='docker container ls'
    alias dckpsa='docker ps -a'
    alias dckrmi='docker image rm'
    alias dckrmd='docker image rm $(docker images -f "dangling=true" -q)'
fi
