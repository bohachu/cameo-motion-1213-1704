#!/bin/bash

the_user=$1
# source .env

echo "處理$the_user my-web HTML目錄..."
if [[ ! -d $HTML_DIR/.$new_user ]]; then
    sudo ln -s /home/$new_user/my-web $HTML_DIR/.$new_user
    echo "$HTML_DIR/.$new_user 已成功創建"
fi
if [[ -d $HTML_DIR/$new_user ]]; then
    sudo rm $HTML_DIR/$new_user
    echo "$HTML_DIR/$new_user 已成功移除"
fi
echo "處理$the_user my-web HTML目錄...完成"


