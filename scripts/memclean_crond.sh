#!/bin/sh

free -m
sudo sh -c 'echo 1 > /proc/sys/vm/drop_caches'
free -m
