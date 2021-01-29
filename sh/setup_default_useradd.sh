#!/bin/bash
source .env

cd /home/$INSTALL_USER/$PRJ_DIR_NAME/sh
if [[ -f /etc/default/useradd ]]; then    
    sudo mv /etc/default/useradd-backup
fi 
sudo /bin/cp useradd-default-template /etc/default/useradd

# sudo cp ~/.bashrc /etc/skel
# sudo cp ~/.bash_logout /etc/skel
sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/etc_skel/.bashrc /etc/skel
sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/etc_skel/.bash_logout /etc/skel
sudo chmod +x /etc/skel/.bashrc
sudo chmod +x /etc/skel/.bash_logout
sudo chmod 755 /etc/skel
# 750會讓 /home/user/my-web無法顯示在網站上

echo "新使用者建立時的預設設定... 完成!"