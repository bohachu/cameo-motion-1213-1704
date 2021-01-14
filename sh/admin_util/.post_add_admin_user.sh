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

source .env

source /root/admin_util/.env


new_user=$1

echo "處理一般使用者權限設定"
sudo bash /root/admin_util/.post_add_user.sh $new_user
echo "開始Admin建立後的後續處理:"

echo "001 add the user to sudo and root"

sudo usermod -a -G sudo $new_user
sudo usermod -a -G root $new_user

echo "002 建立admin_util連結"
sudo ln -s /root/admin_util/.*.sh /home/$new_user/
sudo ln -s /root/admin_util/.env /home/$new_user/

echo "003 複製.ipynb"
sudo /bin/cp /root/admin_util/*.ipynb /home/$new_user/

echo "004 調整權限"
sudo chown $new_user:$new_user /home/$new_user/*.py
sudo chown -R $new_user:$new_user /home/$new_user/*.ipynb
sudo chmod +x /home/$new_user/*.ipynb
# # settings.ipynb只有admin可以操作
sudo chmod 740 /home/$new_user/settings.ipynb
sudo chmod 740 /home/$new_user/admin-settings.ipynb

echo "Post add admin user process completed."

