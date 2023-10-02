#!/usr/bin/env bash

# this script will try to install ble.sh for current
# shell, ble is a command line editor providing  the
# synyax high-lighting and history completation, for
# more information about the project please refer to
# https://github.com/akinomyoga/ble.sh

# this script should be sourced instead of executing

ble_home=${HOME}/programfiles/ble

if [ -d ${ble_home} ]; then
    echo "it seems the current bash has installed ble already"
    echo "please check whether the following dir:"
    echo "${ble_home}"
    echo "is the acutally installation of ble, if not, modify"
    echo "this script to install ble to another location."
    return -1
fi

mkdir -p ${ble_home}
git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git ${ble_home}/ble.sh

# check if your system provide the GNU make, ble requires that
make -C ${ble_home}/ble.sh
echo "source ${ble_home}/ble.sh/out/ble.sh" >> ${HOME}/.bashrc
