#!/bin/bash

the_user=$1
source .env

echo "處理$the_user my-web HTML目錄..."
if [[ ! -d $HTML_DIR/.$the_user ]]; then
    sudo ln -s /home/$the_user/my-web $HTML_DIR/.$the_user
    echo "$HTML_DIR/.$the_user 已成功創建"
fi
if [[ -d $HTML_DIR/$the_user ]]; then
    sudo rm -f $HTML_DIR/$the_user
    echo "$HTML_DIR/$the_user 已成功移除"
fi

sudo chmod 0755 /home/$the_user
echo "/home/$the_user 已改成0755"

echo "處理$the_user my-web HTML目錄...完成"


