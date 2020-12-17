#!/bin/bash
# for ubuntu/debia/kali
# initial folder: 專案目錄/sh
source .env

cd ..
if [[ -d dist ]]; then
    rm -rf dist/*
fi

if [[ ! -d dist ]]; then
    mkdir dist
fi

function compile_module() {
    module_name = $1
    echo "Compiling module_name: $module_name"
    cp -R $module_name dist/
    javascript-obfuscator dist/$module_name/"$module_name.js"
    rm dist/$module_name/"$module_name-obfuscated.js"
    cp dist/$module_name/"$module_name-obfuscated.js" dist/$module_name/"$module_name.js"
    echo "Compiled module_name: $module_name ."
}

# List=( "cameo-divergent-stacked-bars" "cameo-run" "cameo-line" "cameo-rank" "cameo-multi-axis-prediction" "cameo-map-tw" )

# for Item in ${List[*]} 
for Item in "cameo-divergent-stacked-bars" "cameo-run" "cameo-line" "cameo-rank" "cameo-multi-axis-prediction" "cameo-map-tw" ;
  do
    echo "Compiling $Item"
    compile_module $Item
  done

cp -R app-* dist/
echo "Copied app-* modules."
cp -R img dist/
echo "Copied img folder."

cp iek-caraousel.html dist/
cp index.html dist/
echo "Copied *.html."
echo "Compiled in folder dist"