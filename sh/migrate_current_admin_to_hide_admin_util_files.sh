#!/bin/bash

the_user=$1
source .env


sudo bash migrate_current_user_hide_user_html.sh $the_user

sudo chmod 740 /home/$the_user/*.ipynb

sudo bash ./admin_util/.post_add_admin.sh $the_user

#處理 ipynb更名
function remove_if_exists() {
    local filepath=$1
    if [ -f $filepath ]; then
        sudo rm -f $filepath
        echo "sudo rm -f $filepath ...Done!"
    fi
}
remove_if_exists /home/$the_user/admin-settings.ipynb


