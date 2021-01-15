#!/bin/bash
# 使用情境: admin透過jupyterhub GUI建立使用者後自動執行, 或需重新套用設定
# 001 建立密碼
# 002 將預覽my-web連結至HTML目錄下
# 003 將使用者加入analysts group
# 004 設定Home目錄檔案權限
# 005 設定my-web權限
# 用法 ./post_add_user.sh username
# 執行目錄: admin home目錄

source /root/admin_util/.env

the_user=$1

sudo /bin/cp -r /etc/skel/* /home/$the_user/    
sudo chown -R $the_user:$the_user /home/$the_user/
echo "001 將/etc/skel所有檔案複製到使用者home目錄, 套用使用者權限...完成"
# sudo passwd $the_user

if [[ ! -L $HTML_DIR/.$the_user ]]; then
    sudo ln -s /home/$the_user/my-web $HTML_DIR/.$the_user
    
fi
# 改成root:analysts, for www還原
sudo chown -h root:analysts $HTML_DIR/.$the_user
echo "002 建立預覽連結到網頁相對目錄下...完成"


sudo usermod -a -G analysts $the_user
echo "003 add the user to analysts...完成"


sudo chown -R $the_user:analysts /home/$the_user/*.ipynb
sudo chmod +x /home/$the_user/*.ipynb
sudo chmod 0755 /home/$the_user
# 750會讓 my-web無法顯示在網站上
echo "004 設定Home目錄檔案權限...完成"

sudo bash /root/admin_util/.setup_my-web_permission_that_user.sh $the_user
# chown -R $the_user:analysts /home/$the_user/my-web
echo "005 設定my-web權限...完成"
# cd /home/$the_user/my-web
# sudo find . -type d -exec chmod 0755 {} \;
# sudo find . -type f -exec chmod 0744 {} \;

# sudo chmod +x /home/$the_user/my-web/*.ipynb


echo "Post add user process completed."
