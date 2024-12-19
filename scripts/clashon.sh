#!/usr/bin/env bash

# gsettings set org.gnome.system.proxy mode 'manual'
# gsettings set org.gnome.system.proxy.http port 7890
# gsettings set org.gnome.system.proxy.http host '127.0.0.1'
# gsettings set org.gnome.system.proxy.https port 7890
# gsettings set org.gnome.system.proxy.https host '127.0.0.1'
# gsettings set org.gnome.system.proxy.socks port 7891
# gsettings set org.gnome.system.proxy.socks host '127.0.0.1'
# gsettings set org.gnome.system.proxy ignore-hosts "['localhost', '127.0.0.0/8', '::1']"

clash_home=$(dirname $(command -v clash))

read -p "specify a configure directory under the clash root: " confdir
if [ ! -n "${confdir}" ]; then
	echo "no dir specified, use clash root as conf dir"
	confdir=${clash_home}
else
	if [ ! -d ${confdir} ]; then
		echo "specified confdir not exists, use clash root as conf dir"
		confdir=${clash_home}
	fi
fi

nohup ${clash_home}/clash -d ${confdir} > ${clash_home}/clash.log 2>&1 &

export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890

