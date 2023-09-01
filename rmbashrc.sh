#!/usr/bin/env bash

SCRIPT_PATH=$(cd $(dirname ${BASH_SOURCE[0]}); pwd)
echo "\${SCRIPT_PATH}=${SCRIPT_PATH}"
echo "put this shell script to where files need to be backup"

read -p "select a folder for backup files: " backup_dir

if [ ! -d ${backup_dir} ]; then
	mkdir -p ${backup_dir}
fi

backup_list=(
	".bashrc"
	".bash_aliases"
	".bash_func"
	".bash_export"
	".PS1"
	"bashfunc"
	"scripts"
	".vimrc"
	".vim"
)

for item in ${backup_list[@]}
do
	mv ${SCRIPT_PATH}/${item} ${backup_dir}/
done
