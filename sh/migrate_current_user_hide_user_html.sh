#!/bin/bash

the_user=$1
source .env


sudo rm /home/$the_user/*.sh
sudo rm /home/$the_user/*.py
sudo rm /home/$the_user/*.ipynb


if [[ -L $HTML_DIR/$the_user ]]; then
    sudo rm -f $HTML_DIR/$the_user
    echo "$HTML_DIR/$the_user 已成功移除"
fi

#處理 ipynb更名
function remove_if_exists() {
    local filepath=$1
    if [ -f $filepath ]; then
        sudo rm -f $filepath
        echo "sudo rm -f $filepath ...Done!"
    fi
}
# 移除既有 my-web下 .ipynb
List=( "get-myweb-iframe.ipynb" "get-iframe.ipynb" "fork-component.ipynb" "get-preview-address.ipynb" "fork_component.ipynb" "get_preview_address.ipynb" "get_iframe.ipynb" "settings.ipynb")
# cd /home/$the_user/my-web
for Item in ${List[*]} 
  do    
    remove_if_exists /home/$the_user/my-web/$Item
  done


sudo ./admin_util/.post_add_user.sh $the_user
