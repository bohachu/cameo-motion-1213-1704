#!/bin/bash

the_user=$1

TODAY=$(date +"%Y%m%d")

sudo /bin/cp -r /home/$the_user/my-web/ /home/$the_user/history/my-web$TODAY/
sudo chown $the_user:$the_user -R /home/$the_user/history/my-web$TODAY

echo "$the_user/my-web/ was backuped to $the_user/history/my-web$TODAY/"