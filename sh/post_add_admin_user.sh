#!/usr/bin/env bash
# 使用情境: admin透過jupyterhub GUI建立admin使用者後, 手動處理後續
# 001 建立密碼
# 002 建立預覽連結到網頁相對目錄下
# 003 將home目錄該有的檔案放至該目錄下
# 用法 ./post_add_user.sh username
# 執行目錄: admin home目錄

source .env

new_user=$1
echo "開始Admin建立後的後續處理:"
# 建立一般使用者後, admin使用者須跑兩個動作
echo "001 建立 $new_user 密碼
sudo passwd $new_user
echo "002 建立預覽連結到網頁相對目錄下"
if [[ ! -f $HTML_DIR/$new_user ]]; then
    sudo ln -s /home/$new_user/my-web $HTML_DIR/$new_user
fi
echo "003 add the user to analysts and sudo"
sudo usermod -a -G analysts $new_user
sudo usermod -a -G sudo $new_user

chown -R $new_user:analysts ~/my-web
cd ~/my-web
sudo find . -type d -exec chmod 0755 {} \;
sudo find . -type f -exec chmod 0744 {} \;
# function cp_file_from_etcskel() {
#     local filename=$1
#     if [[ ! -f /home/$new_user/$filename ]]; then
#         /bin/cp /etc/skel/$filename /home/$new_user/$filename
#     if
# }
# # 確認my-web 下都有東西
# if [[ ! -d /home/$new_user/my-web/ ]]; then
#     sudo mkdir -p /home/$new_user/my-web/

  # /bin/cp -Rf dist/* /home/$new_user/my-web/
  # /bin/cp homepage.html /home/$new_user/my-web/


  # List=( "get_iframe.ipynb" "fork_component.ipynb" "get_preview_address.ipynb" "settings.ipynb" )
  # for Item in ${List[*]} 
  #   do
  #     echo "cp_file_from_etcskel /etc/skel/$Item /home/$new_user/$Item"
  #     cp_file_from_etcskel $Item
  #   done

# fi
# copy program/admin-settings.ipynb 還原www網站功能
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/program/ipynb/admin-settings.ipynb /home/$new_user


# 複製admin維護工作檔案到家目錄
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/.env /home/$new_user
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/add_user.sh /home/$new_user
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/post_add_user.sh /home/$new_user
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/add_admin_user.sh /home/$new_user
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/post_add_admin_user.sh /home/$new_user
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/update_jupyterhub_config_then_restart.sh /home/$new_user
sudo cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/jupyterhub_config.py /home/$new_user
sudo chown $new_user:$new_user /home/$new_user/.env
sudo chown $new_user:$new_user /home/$new_user/*.sh
sudo chown $new_user:$new_user /home/$new_user/*.py
sudo chown $new_user:$new_user /home/$new_user/*.ipynb
sudo chmod +x /home/$new_user/*.sh
sudo chmod +x /home/$new_user/*.py

sudo chmod +x /home/$new_user/my-web/*.ipynb
sudo chmod +x /home/$new_user/*.ipynb

# settings.ipynb只有admin可以操作
sudo chmod 740 /home/$new_user/settings.ipynb
sudo chmod 740 /home/$new_user/admin-settings.ipynb


echo "Post add admin user process completed."


