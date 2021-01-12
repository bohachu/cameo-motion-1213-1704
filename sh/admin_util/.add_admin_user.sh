#!/usr/bin/env bash
# https://github.com/jupyterhub/ldapauthenticator/issues/54
# source post_add_admin_user.sh
source .env 

user=$1  
# userhome="/home/ad-domain/${user}"
sudo bash .add_user ${user}

sudo bash /root/admin_util/.post_add_admin_user.sh ${user}


# set password
# sudo passwd ${user}

