#!/usr/bin/env bash

function grepkill () {
    if [ $# -eq 0 ]; then
        echo "empty arg"
        return -1
    fi
    
    target_proc=$(ps -aux | tail -n +2 | grep "$1" | grep -v grep)
    if [ -z "$target_proc" ]; then
        echo "no valid process found"
        return -1
    fi
    
    echo "process to be killed:"
    echo "$target_proc"
    
    read -p "confirm to kill? [y/n]" confirm
    
    if [ "$confirm" != "y" ] && [ "$confirm" != "yes" ]; then
        echo "grepkill abort"
        return -1
    fi
    
    target_proc_id=$(echo "$target_proc" | awk '{print $2}' | awk 'ORS=" " {print $1}')
    echo $target_proc_id
    kill $target_proc_id
    return 0
}
grepkill
