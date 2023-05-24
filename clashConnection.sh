gsettings set org.gnome.system.proxy mode 'manual'
gsettings set org.gnome.system.proxy.http port 7890
gsettings set org.gnome.system.proxy.http host '127.0.0.1'
gsettings set org.gnome.system.proxy.https port 7890
gsettings set org.gnome.system.proxy.https host '127.0.0.1'
gsettings set org.gnome.system.proxy.socks port 7891
gsettings set org.gnome.system.proxy.socks host '127.0.0.1'
gsettings set org.gnome.system.proxy ignore-hosts "['localhost', '127.0.0.0/8', '::1']"
cd /home/fredom/ProgramFiles/Clash
./clash-linux-amd64-v3 -d .
cd -
gsettings set org.gnome.system.proxy mode 'auto'
