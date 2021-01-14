#!/usr/bin/env bash
# https://github.com/jupyterhub/ldapauthenticator/issues/54
# 範例:sudo bash .add_admin_user.sh username
# 使用情境: 由terminal 直接建立admin user


source .env 

user=$1  
# userhome="/home/ad-domain/${user}"
sudo bash /root/admin_util/.add_user ${user}
sudo bash /root/admin_util/.post_add_admin.sh ${user}

# set password
# sudo passwd ${user}

