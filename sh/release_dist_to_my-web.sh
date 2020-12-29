#!/bin/bash
# for ubuntu/debia/kali
# initial folder: 專案目錄/sh
# cp to $HTML_DIR, default to /var/www/iek.cameo.tw/html

source .env
cd ..

# overwrite homepage.html for every user
if [[ -f /etc/skel/homepage.html ]]; then
    sudo rm /etc/skel/homepage.html
fi

if [ ! -d /etc/skel/my-web ]; then  
    sudo mkdir -p /etc/skel/my-web
if
sudo /bin/cp -Rf dist/* /etc/skel/my-web/
sudo cp homepage.html /etc/skel/my-web

# cp those ipynb and components
sudo /bin/cp /home/$USER/$PRJ_DIR_NAME/program/ipynb/get_iframe.ipynb /etc/skel/my-web/
sudo /bin/cp /home/$USER/$PRJ_DIR_NAME/program/ipynb/fork_component.ipynb /etc/skel/my-web/
sudo /bin/cp /home/$USER/$PRJ_DIR_NAME/program/ipynb/get_preview_address.ipynb /etc/skel/my-web/
sudo /bin/cp /home/$USER/$PRJ_DIR_NAME/settings.ipynb /etc/skel/


if [ ! -d /etc/skel/my-web/components ]; then  
    sudo mkdir -p /etc/skel/my-web/components
fi
sudo /bin/cp  /home/$USER/$PRJ_DIR_NAME/components/* /etc/skel/my-web/components
