#!/bin/bash

SCRIPT_PATH=$(cd $(dirname ${BASH_SOURCE[0]}); pwd)
echo "\${SCRIPT_PATH}=${SCRIPT_PATH}"
echo ""

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


list=".bashrc .bash_func .bash_func.d .bash_alias .bash_alias.d  .bash_export .bash_export.d .PS1 scripts .vimrc .vim"
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
mkdir ${DST_PATH}/bin
mkdir ${DST_PATH}/programfiles

# prepare an uninstall script
touch ${DST_PATH}/bashrcbak.sh
echo "#!/usr/bin/env bash" > ${DST_PATH}/bashrcbak.sh
echo "list=\"${list}\"" >> ${DST_PATH}/bashrcbak.sh
cat ${SCRIPT_PATH}/bashrcbak.in >> ${DST_PATH}/bashrcbak.sh

cd ${DST_PATH} && source ${DST_PATH}/.bashrc

