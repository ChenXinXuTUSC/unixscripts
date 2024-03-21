#!/usr/bin/env bash

if command -v docker > /dev/null; then
    # alias docker='dck'
    alias dckimg='docker image'
    alias dckctn='docker container'
    alias dcklsi='docker image ls'
    alias dcklsc='docker container ls'
    alias dckpsa='docker ps -a'
    alias dckrmi='docker image rm'
    alias dckrmd='docker image rm $(docker images -f "dangling=true" -q)'
fi
