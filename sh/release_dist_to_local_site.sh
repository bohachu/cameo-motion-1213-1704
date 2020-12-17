#!/bin/bash
# for ubuntu/debia/kali
# initial folder: 專案目錄/sh

source .env
cd ..

# overwrite homepage.html for every user
if [[ -f /etc/skel/homepage.html ]]; then
    sudo rm /etc/skel/homepage.html
fi
sudo cp homepage.html /etc/skel

if [[ -d $HTML_DIR ]]; then
    sudo rm $HTML_DIR
fi

sudo cp -R dist/* $HTML_DIR

