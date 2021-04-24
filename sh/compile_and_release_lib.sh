#!/bin/bash

echo "執行目錄應為 專案目錄/sh ; 開始進行打包dist 並佈署到對應目錄工作:"

echo "將網站打包到dist: 包含js加密和打包, 產出的網站檔案在dist"
bash ./compile.sh
echo "Compile完成。"
source .env

echo "僅將打包的cameo-motion/lib/$JS_LIB_VERSION/*.js 複製進對應的已存在之目錄"

lib_version=$JS_LIB_VERSION #v2
# 回到專案目錄
cd /home/$INSTALL_USER/$PRJ_DIR_NAME
echo $PWD

# HTML_DIR="/var/www/iek.cameo.tw/html"
echo "發佈到網站目錄...$HTML_DIR/cameo-motion/lib/$lib_version/ "
sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/cameo-motion/lib/$lib_version/*.js $HTML_DIR/cameo-motion/lib/$lib_version/
echo "發佈到網站目錄...$HTML_DIR-bak/cameo-motion/lib/$lib_version/ "
sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/cameo-motion/lib/$lib_version/*.js $HTML_DIR-bak/cameo-motion/lib/$lib_version/
echo "發佈到網站目錄完成。"

echo "發佈到預設使用者目錄 /etc/skel/my-web/cameo-motion/lib/$lib_version/ ..."
sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/cameo-motion/lib/$lib_version/*.js /etc/skel/my-web/cameo-motion/lib/$lib_version/
echo "發佈到預設使用者目錄完成。"

echo "重新佈署完成, 請手動更新既有使用者目錄中的檔案"
