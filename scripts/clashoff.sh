clash_procid=$(ps -ef | grep clash | grep -v grep | awk '{print $2}')
if [ -n "${clash_procid}" ]; then
	echo "${clash_procid}" | xargs kill -SIGKILL
	unset HTTP_PROXY
	unset HTTPS_PROXY
	unset FTP_PROXY
	unset ALL_PROXY
else
	echo "no clash process found..."
fi

