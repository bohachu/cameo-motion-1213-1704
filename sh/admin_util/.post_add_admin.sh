#!/bin/bash
# 使用情境: 完成建立使用者程序後,獨立賦予此admin:sudo & root權限和檔案權限
# 用法: sudo bash .post_add_admin.sh username
# 執行目錄: admin home目錄 or /root/admin/

source /root/admin_util/.env

the_user=$1

is_admin=$(sudo bash /root/admin_util/.determine_admin.sh $the_user)
echo "$the_user is admin = $is_admin"

if [ is_admin == "True" ];then
    # echo "is_admin is True in if condision"
    # sudo bash /root/admin_util/.post_add_admin.sh $the_user

    # echo "處理一般使用者權限設定"
    # sudo bash /root/admin_util/.post_add_user.sh $the_user
    echo "開始Admin建立後的後續處理:"

    echo "001 add the user to sudo and root"

    sudo usermod -a -G sudo $the_user
    sudo usermod -a -G root $the_user

    echo "002 建立admin_util連結"
    sudo ln -s /root/admin_util/.*.sh /home/$the_user/
    sudo ln -s /root/admin_util/.env /home/$the_user/

    echo "003 複製.ipynb"
    if [ -f /home/$the_user/系統設定.ipynb ]; then
        sudo rm -f /home/$the_user/系統設定.ipynb
    fi
    if [ ! -f /home/$the_user/管理者系統設定.ipynb ]; then
        sudo /bin/cp /root/admin_util/管理者系統設定.ipynb /home/$the_user/
    fi 

    echo "004 調整權限"
    sudo chown -h $the_user:$the_user /home/$the_user/.*.sh
    sudo chown -h $the_user:$the_user /home/$the_user/.env
    #sudo chown $the_user:$the_user /home/$the_user/*.py
    sudo chown $the_user:$the_user /home/$the_user/*.ipynb
    # sudo chmod +x /home/$the_user/*.ipynb
    # # *.ipynb只有此admin可以操作
    sudo chmod 740 /home/$the_user/*.ipynb
    echo "$the_user admin授權完成!"
else
    echo "$ths_user 非admin,不需設定。"
fi
echo "Post add admin process completed."


