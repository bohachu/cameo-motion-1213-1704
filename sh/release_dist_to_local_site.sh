#!/bin/bash
# for ubuntu/debia/kali
# initial folder: 專案目錄/sh
# 重新打包dist之後, 可執行此程式將檔案複製到HTML_DIR
# cp to $HTML_DIR, default to /var/www/iek.cameo.tw/html

source .env
cd /home/$INSTALL_USER/$PRJ_DIR_NAME


echo "複製到HTML_DIR"

sudo /bin/cp -Rf dist/* $HTML_DIR

echo "複製到html-bak"
if [ ! -d $HTML_DIR-bak ]; then  
    sudo mkdir -p $HTML_DIR-bak
fi
sudo /bin/cp -Rf dist/* $HTML_DIR-bak

sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/program/ipynb/get-www-iframe.ipynb $HTML_DIR/get-www-iframe.ipynb
sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/program/ipynb/get-www-iframe.ipynb $HTML_DIR-bak/get-www-iframe.ipynb

echo "add group analysts"
sudo groupadd analysts

echo "www需要讓特定使用者(如admin group)可以寫入 analysts也可寫入"
sudo chown -R root:analysts $HTML_DIR
sudo chmod -R 775 $HTML_DIR
sudo chown -R root:analysts $HTML_DIR-bak
sudo chmod -R 775 $HTML_DIR-bak
cd $HTML_DIR

sudo find . -type d -exec chmod 0775 {} \;
sudo find . -type f -exec chmod 0774 {} \;

cd $HTML_DIR-bak

sudo find . -type d -exec chmod 0775 {} \;
sudo find . -type f -exec chmod 0774 {} \;


sudo setfacl -R -m d:g:analysts:rwx $HTML_DIR
sudo setfacl -R -m d:g:analysts:rwx $HTML_DIR-bak
echo "非群組的應該都看不到"
sudo setfacl -R -m d:o::rx $HTML_DIR
sudo setfacl -R -m d:o::rx $HTML_DIR-bak
echo "加入權限使預設新建立的檔案都是rx權限:"
sudo setfacl -R -m d:mask:r $HTML_DIR
sudo setfacl -R -m d:mask:r $HTML_DIR-bak

echo "Release dist to local site and bak completed."
