#!/bin/bash

the_user=$1
source .env


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

