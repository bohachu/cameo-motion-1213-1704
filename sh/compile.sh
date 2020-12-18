#!/bin/bash
# for ubuntu/debia/kali
# initial folder: 專案目錄/sh
source .env

lib_version="v1"

# 回到專案目錄
cd ..
echo $PWD
if [[ -d dist ]]; then
    rm -rf dist/*
fi

if [[ ! -d dist ]]; then
    mkdir dist
fi
if [[ ! -d dist/lib/$lib_version ]]; then
    mkdir -p "dist/lib/$lib_version"
fi

cp -R lib/ dist/
cp -R app-* dist/
echo "Copied app-* modules."
cp -R img dist/
echo "Copied img folder."
cp -R scss dist/

cp iek-carousel.html dist/
cp index.html dist/
cp favicon.ico dist/

echo "Copied *.html."

function compile_module() {
    local module_path=$1
    local js_name=$2
    echo "Compiling module_path: $module_path"
    javascript-obfuscator "$module_path/$js_name.js"
    rm "$module_path/$js_name.js"
    cp "$module_path/$js_name-obfuscated.js" "$module_path/$js_name.js"
  
    echo "Compiled module_path: $module_path ."
}

compile_module "dist/lib/$lib_version/cameo-core" "cameo-df"
echo "compile_module dist/lib/$lib_version/cameo-core cameo-df"
compile_module "dist/lib/$lib_version/cameo-core" "cameo-load"
echo "compile_module dist/lib/$lib_version/cameo-core cameo-load"

List=( "cameo-divergent-stacked-bars" "cameo-run" "cameo-line" "cameo-rank" "cameo-multi-axis-prediction" "cameo-map-tw" "cameo-table")

for Item in ${List[*]} 
  do
    echo "compile_module dist/lib/$lib_version/$Item $Item"
    compile_module "dist/lib/$lib_version/$Item" $Item
  done


echo "Compiled in folder dist"

