#!/bin/bash
# 使用情境: admin透過jupyterhub GUI建立admin使用者後, 手動處理後續
# 001 建立密碼
# 002 建立預覽連結到網頁相對目錄下
# 003 將home目錄該有的檔案放至該目錄下
# 用法 ./post_add_user.sh username
# 執行目錄: admin home目錄

source /root/admin_util/.env

the_user=$1

sudo bash /root/admin_util/.post_add_user.sh $the_user

sudo bash /root/admin_util/.post_add_admin.sh $the_user
