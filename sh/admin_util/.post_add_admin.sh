#!/bin/bash
# 使用情境: 完成建立使用者程序後,獨立賦予此admin:sudo & root權限和檔案權限
# 用法: sudo bash .post_add_admin.sh username
# 執行目錄: admin home目錄

source /root/admin_util/.env

new_user=$1

# echo "處理一般使用者權限設定"
# sudo bash /root/admin_util/.post_add_user.sh $new_user
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


