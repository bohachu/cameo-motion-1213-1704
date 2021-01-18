#!/bin/bash
# 使用情境: Deploy admin_util, 給admin使用的工具
# 放到 /root/admin_util
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

sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/program/ipynb/get-iframe.ipynb /root/user_util/
echo "get-iframe.ipynb copied"

sudo chown -R root:analysts /root/user_util
sudo chmod 755 -R /root/user_util/
echo "sudo chown -R root:analysts /root/user_util ...done"
