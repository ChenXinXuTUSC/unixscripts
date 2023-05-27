#!/bin/bash

SCRIPT_PATH=$(cd $(dirname ${BASH_SOURCE[0]}); pwd)
echo "\${SCRIPT_PATH}=${SCRIPT_PATH}"

read -p "specify a path :" DST_PATH
if  [ ! -n "${DST_PATH}" ] ;then
    echo "didn't choose the path, will create in current working dir..."
    path=$(pwd)
else
    echo "template will be generated in ${DST_PATH}"
fi

if  [ ! -d ${DST_PATH} ] ;then
    mkdir -p ${DST_PATH}
fi


list=".bashrc .bash_aliases .bash_func .PS1 bashfunc scripts"
for item in ${list}
do
	if [ -e ${DST_PATH}/${item} ]; then
		mv ${DST_PATH}/${item} ${DST_PATH}/${item}.bak
		echo "${DST_PATH}/${item} renamed to ${DST_PATH}/${item}.bak"
	fi

	if [ -d ${SCRIPT_PATH}/${item} ]; then
		cp -r ${SCRIPT_PATH}/${item} ${DST_PATH}/${item}
	else
		cp ${SCRIPT_PATH}/${item} ${DST_PATH}/${item}
	fi
done

mkdir ${DST_PATH}/log
source ${DST_PATH}/.bashrc
