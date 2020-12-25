#!/usr/bin/env bash
# https://github.com/jupyterhub/ldapauthenticator/issues/54
source .env 

user=$1  
# userhome="/home/ad-domain/${user}"
userhome="/home/${user}"
if id "$1" &>/dev/null; then
    echo 'user already exists'
else
    echo 'user not found; creating user:'
    # Use realmd to add the user with passwd = username
    # realm permit ${user}                   
    sudo useradd -m -p $(openssl passwd -6 ${user}) -G analysts ${user} 
    # sudo useradd -m -p $(openssl passwd -6 tuseradd) -G analysts tuseradd
    # sudo groupadd ${user}
    # sudo usermod -aG ${user} ${user}
    # sudo usermod -g ${user} ${user}
    
    # if [ ! -d "${userhome}" ]; then 
    #      # Create home directory       
    #      sudo mkdir -p "${userhome}"             
    # fi 
    # cp -R /etc/skel ${userhome}
    
    # chown "${user}:domain users" "${userhome}"   
    # sudo chown -R "${user}:analysts" "${userhome}"   

    # Add user to the sharedfolder group
    # usermod -aG sharedfolder ${user}
    sudo usermod -a -G analysts ${user}    
    # add to sudoer
    sudo usermod -a -G sudo ${user} 
    # change my-web permissions
    if [ -d ~/my-web ]; then    
        chown -R $INSTALL_USER:analysts ~/my-web
        # sudo mkdir -p $HTML_DIR/${user}
        sudo ln -s ~/my-web $HTML_DIR/${user}
        # sudo mkdir -p $HTML_DIR/${user}
        # sudo ln -s ~/my-web $HTML_DIR/${user}/my-web
        cd ~/my-web
        sudo find . -type d -exec chmod 0755 {} \;
        sudo find . -type f -exec chmod 0744 {} \;
        cd ..       
        sudo setfacl -R -m d:g:analysts:rwx ~/my-web
        # 非群組的應該都看不到
        sudo setfacl -R -m d:o::rx ~/my-web
        # 加入權限使預設新建立的檔案都是rx權限:
        sudo setfacl -R -m d:mask:r ~/my-web

        # 複製admin維護工作檔案到家目錄
        sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/.env /home/$INIT_ADMIN_USER
        sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/add_user.sh /home/$INIT_ADMIN_USER
        sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/add_admin_user.sh /home/$INIT_ADMIN_USER
        sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/update_jupyterhub_config_then_restart.sh /home/$INIT_ADMIN_USER
        sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/jupyterhub_config.py /home/$INIT_ADMIN_USER
        sudo chown $INIT_ADMIN_USER:$INIT_ADMIN_USER /home/$INIT_ADMIN_USER/.env
        sudo chown $INIT_ADMIN_USER:$INIT_ADMIN_USER /home/$INIT_ADMIN_USER/*.sh
        sudo chown $INIT_ADMIN_USER:$INIT_ADMIN_USER /home/$INIT_ADMIN_USER/*.py
        sudo chmod +x /home/$INIT_ADMIN_USER/*.sh
        sudo chmod +x /home/$INIT_ADMIN_USER/*.py

        
    fi 

    # Create notebook directory and symlink the datalab folder into it
    # sudo mkdir -p ${userhome}/notebooks  
    # chown ${user}:domain\ users ${userhome}/notebooks -R  
    # sudo chown -R ${user}:analysts ${userhome}/notebooks 

    # Symlink a shared folder into the user notebook directory
    # ln -s /home/sharedfolder ${userhome}/notebooks/sharedfolder
    # sudo ln -s /srv/data/share_data_analysts  /home/${user}/share_data_analysts  

fi


# set password
# sudo passwd ${user}

