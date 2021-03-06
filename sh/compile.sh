#!/bin/bash
# for ubuntu/debia/kali
# initial folder: 專案目錄/sh
# 不包含 components內的東西
# 複製到 dist/
source .env


lib_version=$JS_LIB_VERSION #v2

# 回到專案目錄
cd /home/$INSTALL_USER/$PRJ_DIR_NAME
echo $PWD
if [[ -d /home/$INSTALL_USER/$PRJ_DIR_NAME/dist ]]; then
    rm -rf /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/*
    echo "/home/$INSTALL_USER/$PRJ_DIR_NAME/dist/ 移除完成"
fi

if [[ ! -d /home/$INSTALL_USER/$PRJ_DIR_NAME/dist ]]; then
    mkdir -p /home/$INSTALL_USER/$PRJ_DIR_NAME/dist
fi
if [[ ! -d /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/cameo-motion/lib/$lib_version ]]; then
    mkdir -p /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/cameo-motion/lib/$lib_version
fi
if [[ ! -d /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/cdn.amcharts.com/lib/4 ]]; then
    mkdir -p /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/cdn.amcharts.com/lib/4
fi
if [[ ! -d /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/www.amcharts.com/lib/4/plugins ]]; then
    mkdir -p /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/www.amcharts.com/lib/4/plugins
fi

/bin/cp -R /home/$INSTALL_USER/$PRJ_DIR_NAME/cameo-motion/lib/$lib_version/* /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/cameo-motion/lib/$lib_version
/bin/cp -R /home/$INSTALL_USER/$PRJ_DIR_NAME/app-* /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/
/bin/cp -R /home/$INSTALL_USER/$PRJ_DIR_NAME/www.amcharts.com/lib/4/plugins/* /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/www.amcharts.com/lib/4/plugins/
/bin/cp -R /home/$INSTALL_USER/$PRJ_DIR_NAME/cdn.amcharts.com/lib/4/* /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/cdn.amcharts.com/lib/4/

# cp -R cameo-* dist/
echo "Copied app-* and cameo-* modules to dist."
/bin/cp -R img /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/
/bin/cp -R scss /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/
echo "Copied img and scss folder."
/bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/iek-carousel.html /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/
/bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/index.html /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/
/bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/favicon.ico /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/
/bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/homepage.html /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/
echo "Copied favicon.ico and *.html."

function compile_module() {
    local module_path=$1
    local js_name=$2
    echo "Compiling fpath: $module_path/$js_name.js"
    javascript-obfuscator "$module_path/$js_name.js"
    rm "$module_path/$js_name.js"
    /bin/cp "$module_path/$js_name-obfuscated.js" "$module_path/$js_name.js"
    rm "$module_path/$js_name-obfuscated.js"
    echo "Compiled js: $module_path/$js_name.js ."
}
# echo "compile_module dist/lib/$lib_version/cameo-core cameo-df"
# compile_module "/home/$INSTALL_USER/$PRJ_DIR_NAME/dist/cameo-motion/lib/$lib_version/cameo-core" "cameo-df"
# echo "compile_module /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/cameo-motion/lib/$lib_version/cameo-core cameo-load"
# compile_module "/home/$INSTALL_USER/$PRJ_DIR_NAME/dist/cameo-motion/lib/$lib_version" "cameo-load"
# echo "compile_module /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/lib/$lib_version/cameo-motion/cameo-table cameo-table" 
# compile_module "/home/$INSTALL_USER/$PRJ_DIR_NAME/dist/cameo-motion/lib/$lib_version/cameo-motion/cameo-table" "cameo-table"


List=( "cameo-am-element" "cameo-clean" "cameo-divergent-stacked-bars" "cameo-line" "cameo-map-tw" "cameo-multi-axis-prediction" "cameo-rank" "cameo-run" )

for Item in ${List[*]} 
  do
    compile_module "/home/$INSTALL_USER/$PRJ_DIR_NAME/dist/cameo-motion/lib/$lib_version" $Item
    echo "compile_module dist/lib/$lib_version $Item ... Done"
  done

# TODO: 未來需要修改路徑, 讓dist 和www 目錄不須有components (須同步修改release_dist_to_my-web.sh)
echo "Copy components/* to /home/$INSTALL_USER/$PRJ_DIR_NAME/dist"
if [ ! -d /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/components ]; then  
    sudo mkdir -p /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/components
fi

sudo /bin/cp -Rf /home/$INSTALL_USER/$PRJ_DIR_NAME/components/* /home/$INSTALL_USER/$PRJ_DIR_NAME/dist/components/


echo "JS Compiled in folder dist"

