#!/bin/bash
# 使用情境: admin透過jupyterhub GUI建立使用者後, 手動處理後續
# 001 建立密碼
# 002 將預覽my-web連結至HTML目錄下
# 003 將使用者加入analysts group
# 004 設定Home目錄檔案權限
# 005 設定my-web權限
# 用法 ./post_add_user.sh username
# 執行目錄: admin home目錄

source /root/admin_util/.env

the_user=$1

echo "001 建立密碼"
sudo passwd $the_user
echo "002 建立預覽連結到網頁相對目錄下"
if [[ ! -d $HTML_DIR/.$the_user ]]; then
    sudo ln -s /home/$the_user/my-web $HTML_DIR/.$the_user
fi

echo "003 add the user to analysts"
sudo usermod -a -G analysts $the_user

echo "004 設定Home目錄檔案權限"
sudo chown -R $the_user:analysts /home/$the_user/*.ipynb
sudo chmod +x /home/$the_user/*.ipynb
sudo chmod 0755 /home/$the_user
# 750會讓 my-web無法顯示在網站上

echo "005 設定my-web權限"
sudo bash /root/admin_util/.setup_my-web_permission_that_user.sh $the_user
# chown -R $the_user:analysts /home/$the_user/my-web

# cd /home/$the_user/my-web
# sudo find . -type d -exec chmod 0755 {} \;
# sudo find . -type f -exec chmod 0744 {} \;

# sudo chmod +x /home/$the_user/my-web/*.ipynb


echo "Post add user process completed."
