#!/bin/bash
# Jupyterhub / Hub Control Panel / admin介面, 移除使用者後, 可以再
# 001 移除 user home目錄和其他資料
# 002 移除 www 目錄下的超連結

the_user=$1
source /root/admin_util/.env

sudo deluser --remove-all-files $the_user
echo "001 使用者目錄移除...成功。"

sudo rm -f $HTML_DIR/.$the_user
echo "002 使用者WWW連結移除...成功。"

echo "使用者 $the_user 資料移除 完成!"
