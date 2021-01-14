#!/bin/bash

the_user=$1
source .env

sudo bash migrate_current_user_hide_user_html.sh $the_user


echo "remove $the_user obsolete admin util files"
sudo rm /home/$the_user/*.sh
sudo rm /home/$the_user/*.py
sudo rm /home/$the_user/*.ipynb

#處理 ipynb更名
function remove_if_exists() {
    local filepath=$1
    if [ -f $filepath ]; then
        sudo rm -f $filepath
        echo "sudo rm -f $filepath ...Done!"
    fi
}
remove_if_exists /home/$the_user/admin-settings.ipynb

echo "Copy $the_user latest admin util files"
sudo usermod -a -G root $the_user

sudo bash ./admin_util/.post_add_admin.sh $the_user

remove_if_exists /home/$the_user/admin-settings.ipynb

echo "migrate admin done!"