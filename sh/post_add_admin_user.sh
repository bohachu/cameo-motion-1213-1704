#!/usr/bin/env bash
# 使用情境: admin透過jupyterhub GUI建立admin使用者後, 手動處理後續
# 001 建立密碼
# 002 建立預覽連結到網頁相對目錄下
# 003 將home目錄該有的檔案放至該目錄下
# 用法 ./post_add_user.sh username
# 執行目錄: admin home目錄

source .env

new_user=$1
# 建立一般使用者後, admin使用者須跑兩個動作
# 001 建立密碼
sudo passwd $new_user
# 002 建立預覽連結到網頁相對目錄下
sudo ln -s /home/$new_user/my-web $HTML_DIR/$new_user

# 確認my-web 下都有東西
if [[ ! -d /home/$new_user/my-web/ ]]; then
    sudo mkdir -p /home/$new_user/my-web/
if
/bin/cp -Rf dist/* /home/$new_user/my-web/
/bin/cp homepage.html /home/$new_user/my-web/

function cp_file_from_etcskel() {
    local filename=$1
    if [[ ! -f /home/$new_user/$filename ]]; then
        /bin/cp /etc/skel/$filename /home/$new_user/$filename
    if
}
List=( "get_iframe.ipynb" "fork_component.ipynb" "get_preview_address.ipynb" "settings.ipynb" )


for Item in ${List[*]} 
  do
    echo "cp_file_from_etcskel /etc/skel/$Item /home/$new_user/$Item"
    cp_file_from_etcskel $Item
  done



# 複製admin維護工作檔案到家目錄
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/.env /home/$INIT_ADMIN_USER
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/add_user.sh /home/$INIT_ADMIN_USER
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/post_add_user.sh /home/$INIT_ADMIN_USER
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/add_admin_user.sh /home/$INIT_ADMIN_USER
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/post_add_admin_user.sh /home/$INIT_ADMIN_USER
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/update_jupyterhub_config_then_restart.sh /home/$INIT_ADMIN_USER
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/jupyterhub_config.py /home/$INIT_ADMIN_USER
sudo chown $INIT_ADMIN_USER:$INIT_ADMIN_USER /home/$INIT_ADMIN_USER/.env
sudo chown $INIT_ADMIN_USER:$INIT_ADMIN_USER /home/$INIT_ADMIN_USER/*.sh
sudo chown $INIT_ADMIN_USER:$INIT_ADMIN_USER /home/$INIT_ADMIN_USER/*.py
sudo chmod +x /home/$INIT_ADMIN_USER/*.sh
sudo chmod +x /home/$INIT_ADMIN_USER/*.py

# copy program/admin-settings.ipynb 還原www網站功能
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/program/ipynb/admin-settings.ipynb /home/$new_user

echo "Post add admin user process completed."


