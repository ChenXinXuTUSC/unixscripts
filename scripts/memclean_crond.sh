#!/bin/sh

free -m
sh -c 'echo 1 > /proc/sys/vm/drop_caches'
free -m
