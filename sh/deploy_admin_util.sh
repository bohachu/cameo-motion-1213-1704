#!/bin/bash
# 使用情境: Deploy admin_util, 給admin使用的工具
# 放到 /root/admin_util
source .env
if [[ ! -d /root/admin_util ]]; then
    sudo mkdir -p /root/admin_util
    sudo chown -R root:root /root/admin_util
    sudo chmod 770 -R /root/admin_util/
fi

sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/program/ipynb/admin-settings.ipynb /root/admin_util/

sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/admin_util/.*.sh /root/admin_util/
sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/admin_util/*.ipynb /root/admin_util/

sudo ln -s /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/.env /root/admin_util/.env
sudo chown -R root:root /root/admin_util
sudo chmod 770 -R /root/admin_util/
# sudo chmod +x /root/admin_util/.*.sh
# sudo chmod +x /root/admin_util/*.ipynb

echo "完成佈署admin_util維護工具。"

# 複製admin維護工作檔案到家目錄
# sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/.env /home/$new_user
# sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/admin_util/.add_user.sh /home/$new_user
# sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/admin_util/.post_add_user.sh /home/$new_user
# sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/admin_util/.add_admin_user.sh /home/$new_user
# sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/admin_util/.post_add_admin_user.sh /home/$new_user
# sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/admin_util/.setup_my-web_permission_that_user.sh /home/$new_user