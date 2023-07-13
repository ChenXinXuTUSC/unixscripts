ps -ef | grep clash | grep -v grep | awk '{print $2}' | xargs kill -SIGKILL
gsettings set org.gnome.system.proxy mode 'auto'
unset http_proxy
unset https_proxy
unset ftp_proxy
unset all_proxy
