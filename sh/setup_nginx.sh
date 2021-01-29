#!/bin/bash
source .env

cd /home/$INSTALL_USER/$PRJ_DIR_NAME/sh
sudo systemctl stop nginx
if [ ! -d /etc/nginx/sites-available/$SITE_DOMAIN ]; then 
    sudo mkdir -p /etc/nginx/sites-available/$SITE_DOMAIN
fi
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/nginx_http.conf /etc/nginx/sites-available/$SITE_DOMAIN/nginx_http.conf
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/htpasswd /etc/nginx/htpasswd
if [ ! -d /etc/ssl/certs ]; then    
    sudo mkdir -p /etc/ssl/certs
fi 
sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 4096

sudo rm /etc/nginx/sites-enabled/default
sudo ln -s /etc/nginx/sites-available/$SITE_DOMAIN/nginx_http.conf /etc/nginx/sites-enabled/$SITE_DOMAIN.conf


sudo /etc/init.d/nginx reload
sudo systemctl stop nginx
sudo systemctl start nginx

echo "Nginx設定...完成!"