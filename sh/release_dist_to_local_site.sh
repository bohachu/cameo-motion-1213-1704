#!/bin/bash
# for ubuntu/debia/kali
# initial folder: 專案目錄/sh
# 重新打包dist之後, 可執行此程式將檔案複製到HTML_DIR
# cp to $HTML_DIR, default to /var/www/iek.cameo.tw/html

source .env
cd ..


# overwrite homepage.html for every user
if [[ -f /etc/skel/homepage.html ]]; then
    sudo rm /etc/skel/homepage.html
fi
sudo cp homepage.html /etc/skel/

# if [[ -d $HTML_DIR ]]; then
#     sudo rm $HTML_DIR
# fi

# 複製到

sudo /bin/cp -Rf dist/* $HTML_DIR

# 複製到html-bak
if [ ! -d $HTML_DIR-bak ]; then  
    sudo mkdir -p $HTML_DIR-bak
fi
sudo /bin/cp -Rf dist/* $HTML_DIR-bak

