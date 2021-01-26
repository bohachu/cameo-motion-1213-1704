#!/bin/bash

the_user=$1
backup_source=/home/$the_user/my-web
postfix=$(date +"%Y%m%d")

# sudo /bin/cp -r /home/$the_user/my-web/ /home/$the_user/history/my-web$TODAY/
# sudo chown $the_user:$the_user -R /home/$the_user/history/my-web$TODAY
sudo ./backup_folder.sh $the_user $backup_source $postfix

# echo "$the_user/my-web/ was backuped to $the_user/history/my-web$TODAY/"