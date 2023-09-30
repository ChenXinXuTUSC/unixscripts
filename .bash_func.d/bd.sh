#!/bin/bash

bcd()
{
	if [ ! -n "${1}" ]; then
		echo "please specify backward level <num>"
		exit -1
	fi

	updir="../"
	for((i = 1; i < ${1}; i++)); do
		updir="${updir}${updir}"
	done

	cd ${updir}
}

alias bd='bcd'
