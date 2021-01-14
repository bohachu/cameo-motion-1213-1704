#!/usr/bin/env bash
# https://github.com/jupyterhub/ldapauthenticator/issues/54
# init folder: /home/$USER/$PRJ_DIR_NAME/sh or /root/admin_util/
# 使用情境: 
# 001 hun control panel admin 建立使用者時會呼叫此指令
# 002 sudo/admin手動透過terminal 建立使用者
# 動作:
# 001 建立使用者, 密碼與使用者帳號一樣
# 002 建立使用者home目錄, 將/etc/skel所有檔案複製到使用者home目錄, 套用使用者權限
# 003 執行post_add_user動作

source .env 

user=$1  
# userhome="/home/ad-domain/${user}"
# userhome="/home/${user}"
if id "$1" &>/dev/null; then
    echo 'user already exists'
else
    echo 'user not found; creating user:'
    # Use realmd to add the user with passwd = username
    # realm permit ${user}                   
    sudo useradd -m -p $(openssl passwd -6 ${user}) -G analysts ${user} 
    echo "001 建立使用者, 密碼與使用者帳號一樣...完成"
    sudo mkdir -p $userhome
    sudo chown ${user}:${user} userhome
    sudo cp -r /etc/skel/* /home/${user}/    
    sudo chown -R ${user}:${user} /home/${user}/
    echo "002 建立使用者home目錄, 將/etc/skel所有檔案複製到使用者home目錄, 套用使用者權限...完成"
fi

sudo bash /root/admin_util/.post_add_user.sh ${user}
echo "003 執行post_add_user動作..完成"

echo "add_user $user 完成!"
# set password
# sudo passwd ${user}

