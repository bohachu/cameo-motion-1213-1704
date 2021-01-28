#!/bin/bash
# 使用情境: Deploy user_util, 給user使用的工具
# 放到 /root/user_util
source .env
if [[ -d /root/user_util ]]; then
    sudo rm -rf /root/user_util
    echo "已移除既有 /root/admin_util"
fi

if [[ ! -d /root/user_util ]]; then
    sudo mkdir -p /root/user_util
    sudo chown -R root:analysts /root/user_util
    sudo chmod 755 -R /root/user_util/
    echo "已建立 /root/admin_util/"
fi

sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/program/ipynb/.sys_util_user.py /root/user_util/
echo ".sys_util_user.py copied"
sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/program/ipynb/get-iframe.ipynb /root/user_util/
echo "get-iframe.ipynb copied"
sudo chown -R root:analysts /root/user_util
sudo chmod 755 -R /root/user_util/
echo "sudo chown -R root:analysts /root/user_util ...done"

echo "完成佈署user_util維護工具。"