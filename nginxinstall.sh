sudo apt-get install nginx
sudo ufw allow http
sudo ufw allow https
sudo ufw allow ftp

if [ ! -d /etc/nginx/sites-available ]; then
	echo "please check the installation of nginx"
	exit -1
fi

nginx_prefix=/etc/nginx/sites-available

if [ ! -f ${nginx_prefix}/default ]; then
	echo "default config not found"
	exit -1
fi

mv ${nginx_prefix}/default ${nginx_prefix}/default.backup
touch ${nginx_prefix}/default
sudo bash -c "cat > ${nginx_prefix}/default <<- 'EOF'
server {
	listen 80;

	location / {
		proxy_pass http://localhost:3000;
		proxy_http_version 1.1;
		proxy_set_header Upgrade \$http_upgrade;
		proxy_set_header Connection 'upgrade';
		proxy_set_header Host \$host;
		proxy_cache_bypass \$http_upgrade;
	}
}
EOF"

# restart nginx to load default configuration
sudo systemctl restart nginx

