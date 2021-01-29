#!/bin/bash
# 使用情境: Deploy admin_util, 給admin使用的工具
# 放到 /root/admin_util
source .env
if [[ -d /root/admin_util ]]; then
    sudo rm -rf /root/admin_util
    echo "已移除既有 /root/admin_util"
fi

if [[ ! -d /root/admin_util ]]; then
    sudo mkdir -p /root/admin_util
    sudo chown -R root:root /root/admin_util
    sudo chmod 770 -R /root/admin_util/
    echo "已建立 /root/admin_util/"
fi

sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/program/ipynb/sys_util_admin.py /root/admin_util/
echo "sys_util_admin.py copied"

sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/program/ipynb/管理者系統設定.ipynb /root/admin_util/
echo "管理者系統設定.ipynb copied"

sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/admin_util/.*.sh /root/admin_util/
echo ".*.sh copied"
sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/.env /root/admin_util/.env
echo ".env copied"
sudo chown -R root:root /root/admin_util
echo "sudo chown -R root:root /root/admin_util ...done"

sudo chown :analysts /root/admin_util/.setup_my-web_permission_that_user.sh
echo "chown :analysts /root/admin_util/.setup_my-web_permission_that_user.sh ...done"

sudo chmod 770 -R /root/admin_util/
echo "sudo chmod 770 -R /root/admin_util/ ...done"

echo "完成佈署admin_util維護工具。"
