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

echo "處理$the_user my-web HTML目錄...完成"

sudo chmod 0755 /home/$the_user
echo "/home/$the_user 已改成0755"



#處理 ipynb更名
function remove_if_exists() {
    local filepath=$1
    if [ -f $filepath ]; then
        sudo rm -f $filepath
        echo "sudo rm -f $filepath ...Done!"
    fi
}
# 移除既有 my-web下 .ipynb
List=( "get-myweb-iframe.ipynb" "get-iframe.ipynb" "fork-component.ipynb" "get-preview-address.ipynb" )
# cd /home/$the_user/my-web
for Item in ${List[*]} 
  do    
    remove_if_exists /home/$the_user/my-web/$Item
  done


sudo /bin/cp /etc/skel/my-web/my-web功能設定.ipynb /home/$the_user/my-web/
echo "/home/$the_user/my-web/*.ipynb -> /home/$the_user/my-web/my-web功能設定.ipynb ...Done!"

remove_if_exists /home/$the_user/settings.ipynb

sudo /bin/cp /etc/skel/系統設定.ipynb /home/$the_user/
echo "/home/$the_user/settings.ipynb -> /home/$the_user/系統設定.ipynb ...Done!"
