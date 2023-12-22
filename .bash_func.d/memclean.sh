#!/bin/bash

memclean()
{
	free -h
	sudo sh -c 'echo 1 > /proc/sys/vm/drop_caches'
	free -h
}
