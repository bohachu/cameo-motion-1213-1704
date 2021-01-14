#!/bin/bash

the_user=$1
source .env


sudo rm /home/$the_user/*.sh
sudo rm /home/$the_user/*.py
sudo rm /home/$the_user/*.ipynb

sudo /bin/cp -r /etc/skel/* /home/$the_user/
sudo chown -R $the_user:$the_user/home/$the_user/
echo "重新複製與deploy $the_user 家目錄 完成"

echo "設定my-web權限"
sudo bash /root/admin_util/.setup_my-web_permission_that_user.sh $the_user

echo "處理$the_user my-web HTML目錄..."
if [[ ! -d $HTML_DIR/.$the_user ]]; then
    sudo ln -s /home/$the_user/my-web $HTML_DIR/.$the_user
    echo "$HTML_DIR/.$the_user 已成功創建"
fi
if [[ -d $HTML_DIR/$the_user ]]; then
    sudo rm -f $HTML_DIR/$the_user
    echo "$HTML_DIR/$the_user 已成功移除"
fi


sudo chmod 0755 /home/$the_user
echo "/home/$the_user 已改成0755"

# cp /etc/skel/.user-env /home/$the_user/
# echo "/home/$the_user 已取得.user-env"

echo "處理$the_user my-web HTML目錄...完成"



