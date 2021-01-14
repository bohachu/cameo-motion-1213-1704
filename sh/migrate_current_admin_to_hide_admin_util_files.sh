#!/bin/bash

the_user=$1
source .env

echo "remove $the_user obsolete admin util files"
sudo rm /home/$the_user/*.sh
sudo rm /home/$the_user/*.py
sudo rm /home/$the_user/*.ipynb

sudo bash migrate_current_user_hide_user_html.sh $the_user

sudo chmod 740 /home/$the_user/*.ipynb

sudo bash ./admin_util/.post_add_admin.sh $the_user
