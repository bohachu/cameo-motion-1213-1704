#!/usr/bin/env bash
# 使用情境: admin透過jupyterhub GUI建立使用者後, 手動處理後續
# 001 建立密碼
# 002 建立預覽連結到網頁相對目錄下
# 用法 ./post_add_user.sh username
# 執行目錄: admin home目錄

source .env

new_user=$1
# 建立一般使用者後, admin使用者須跑兩個動作
# 001 建立密碼
sudo passwd $new_user
# 002 建立預覽連結到網頁相對目錄下
if [[ ! -d $HTML_DIR/$new_user ]]; then
    sudo ln -s /home/$new_user/my-web $HTML_DIR/$new_user
fi

# 003 add the user to analysts
sudo usermod -aG analysts $new_user

chown -R $new_user:analysts /home/$new_user/my-web
chown -R $new_user:analysts /home/$new_user/*.ipynb
cd /home/$new_user/my-web
sudo find . -type d -exec chmod 0755 {} \;
sudo find . -type f -exec chmod 0744 {} \;
# # 確認my-web 下都有東西
# function cp_file_from_etcskel() {
#     local filename=$1
#     if [[ ! -f /home/$new_user/$filename ]]; then
#         /bin/cp /etc/skel/$filename /home/$new_user/$filename
#     if
# }
# if [[ ! -d /home/$new_user/my-web/ ]]; then
#     sudo mkdir -p /home/$new_user/my-web/

## already copied /etc/skel/* to home/newuser
  # /bin/cp -Rf /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/* /home/$new_user/my-web/
  # /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/homepage.html /home/$new_user/my-web/


  # List=( "get_iframe.ipynb" "fork_component.ipynb" "get_preview_address.ipynb" "settings.ipynb" )


  # for Item in ${List[*]} 
  #   do
  #     echo "cp_file_from_etcskel /etc/skel/$Item /home/$new_user/$Item"
  #     cp_file_from_etcskel $Item
  #   done
# if

sudo chmod +x /home/$new_user/my-web/*.ipynb
sudo chmod +x /home/$new_user/*.ipynb

echo "Post add user process completed."
