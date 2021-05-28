#!/bin/bash
source .env

the_user=root
backup_source=$HTML_DIR
postfix=$(date +"%Y%m%d")

# www:
# source: /var/www/iek.cameo.tw/html
# target: /var/www/iek.cameo.tw/html_bak$postfix
# backup_dest=$backup_source"_"bak$postfix

sudo ./backup_folder.sh $the_user $backup_source $postfix