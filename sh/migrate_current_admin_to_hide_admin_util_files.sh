#!/bin/bash

the_user=$1
source .env


<<<<<<< HEAD
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

=======
if [[ ! -d $HTML_DIR/.$new_user ]]; then
    sudo ln -s /home/$new_user/my-web $HTML_DIR/.$new_user
fi
if [[ -d $HTML_DIR/$new_user ]]; then
    sudo rm $HTML_DIR/$new_user
fi

echo "remove $the_user obsolete admin util files"
sudo rm /home/$the_user/*.sh

echo "Copy $the_user latest admin util files"
sudo usermod -a -G root $the_user
sudo ln -s /root/admin_util/* /home/$the_user/
>>>>>>> f701048 (AC:hide admin files to root/admin_util)

