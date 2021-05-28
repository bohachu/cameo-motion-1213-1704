#!/bin/bash
# source .env
the_user=$1
backup_source=$2 #$HTML_DIR
postfix=$3 #$(date +"%Y%m%d")
# myweb:
# source:  /home/$the_user/myweb
# target: /home/$the_user/history/myweb_bak$postfix
# backup_dest=/home/$the_user/myweb/history/myweb_bak$postfix
# www:
# source: /var/www/iek.cameo.tw/html
# target: /var/www/iek.cameo.tw/html_bak$postfix
# backup_dest=$backup_source"_"bak$postfix
if [[ $backup_source == *"myweb"* ]]; then
  backup_dest=/home/$the_user/myweb/history/myweb_bak$postfix
  sudo /bin/cp -r $backup_source/ $backup_dest/
  sudo chown $the_user:$the_user -R $backup_dest
else
  backup_dest=$backup_source"_"bak$postfix
  sudo /bin/cp -r $backup_source/ $backup_dest/
  sudo chown $the_user:analysts -R $backup_dest
fi

echo "$backup_source was backuped to $backup_dest"