gsettings set org.gnome.system.proxy mode 'manual'
gsettings set org.gnome.system.proxy.http port 7890
gsettings set org.gnome.system.proxy.http host '127.0.0.1'
gsettings set org.gnome.system.proxy.https port 7890
gsettings set org.gnome.system.proxy.https host '127.0.0.1'
gsettings set org.gnome.system.proxy.socks port 7891
gsettings set org.gnome.system.proxy.socks host '127.0.0.1'
gsettings set org.gnome.system.proxy ignore-hosts "['localhost', '127.0.0.0/8', '::1']"

CLASH_HOME=/home/fredom/programfiles/Clash
cd ${CLASH_HOME}
read -p "specify a configure directory under the clash root: " confdir
if [ ! -n "${confdir}" ]; then
	echo "no dir specified, use default configuration..."
	confdir=default
else
	if [ ! -d ${confdir} ]; then
		echo "specified confdir not exists, use default configuration..."
		confdir=default
	fi
fi

nohup ./clash-linux-amd64-v3 -d ${confdir} > clash.log 2>&1 &
cd -
