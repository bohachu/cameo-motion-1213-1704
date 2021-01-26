#!/bin/bash
source .env

the_user=root
backup_source=$HTML_DIR
postfix=$(date +"%Y%m%d")

sudo ./backup_folder.sh $the_user $backup_source $postfix