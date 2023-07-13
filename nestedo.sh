#!/bin/bash

function apply_cmd_recursively()
{
	# receive the command
	local cmd=$1
	local pth=$2

	for node in ${pth}/*; do
		if [ -d ${node} ]; then
			# cmd `basename` could obtain the last part of an absolute path
			apply_cmd_recursively ${cmd} ${node}
		else
			${cmd} ${node}
		fi
	done
}



script_path=$(cd $(dirname ${BASH_SOURCE[0]}); pwd)
echo "script_path=${script_path}"

read -p "specify the command to be executed: " the_cmd
if [ ! -n "${the_cmd}" ]; then
	echo "no command received"
	exit -1
fi

read -p "specify a path: " dst_pth
if [ ! -n "${dst_pth}" ] ;then
    echo "didn't choose the path, will create in current working dir..."
    dst_pth=$(pwd)
elif [! -d ${dst_pth} ]; then
	echo "specified path is not a directory"
	exit -1
else
    echo "command will be applied to files in ${dst_pth}"
fi

if  [ ! -d ${dst_pth} ] ;then
    echo "specified path not exists"
	exit -1
fi

# convert to absolute path
dst_pth=$(cd ${dst_pth}; pwd)

apply_cmd_recursively ${the_cmd} ${dst_pth}
