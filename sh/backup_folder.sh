#!/bin/bash
# source .env
the_user=$1
backup_source=$2 #$HTML_DIR

postfix=$3 #$(date +"%Y%m%d")
backup_dest=$backup_source"_"$postfix

sudo /bin/cp -r $backup_source/ $backup_dest/
sudo chown $the_user:$the_user -R $backup_dest

echo "$backup_source was backuped to $backup_dest"