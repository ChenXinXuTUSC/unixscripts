#!/bin/sh

free -h
sh -c 'echo 1 > /proc/sys/vm/drop_caches'
free -h
