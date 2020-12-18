#!/bin/bash
# for ubuntu/debia/kali
# initial folder: 專案目錄/sh
source .env

version = "v1"

# 回到專案目錄
cd ..
if [[ -d dist ]]; then
    rm -rf dist/*
fi

if [[ ! -d dist ]]; then
    mkdir dist
fi
if [[ ! -d dist/lib/$version ]]; then
    mkdir "dist/$version"
fi


cp -R lib/${version} dist/lib/

cp -R cameo-* dist/
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
    local module_path  $1
    local js_name = $2
    echo "Compiling module_path: $module_path"
    javascript-obfuscator $module_path/"$js_name.js"
    rm $module_path/"$js_name.js"
    cp $module_path/"$js_name-obfuscated.js" $module_path/"$js_name.js"
  
    echo "Compiled module_path: $module_path ."
    #   echo "Compiling module_path: $1"
    # javascript-obfuscator "$1/$2.js"
    # rm "$1/$2.js"
    # cp "$1/$2-obfuscated.js" "$1/$2.js"
  
    # echo "Compiled module_path: $module_path ."
}

compile_module "dist/lib/$version/cameo-core" "cameo-df"
echo "compile_module dist/lib/$version/cameo-core cameo-df
compile_module "dist/lib/$version/cameo-core" "cameo-load"
echo "compile_module dist/lib/$version/cameo-core cameo-load"

List=( "cameo-divergent-stacked-bars" "cameo-run" "cameo-line" "cameo-rank" "cameo-multi-axis-prediction" "cameo-map-tw" "cameo-table")

for Item in ${List[*]} 
  do
    echo "compile_module dist/lib/$version/$Item $Item"
    compile_module "dist/lib/$version/$Item" $Item
  done


echo "Compiled in folder dist"