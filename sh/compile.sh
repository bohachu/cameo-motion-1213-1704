#!/bin/bash
# for ubuntu/debia/kali
# initial folder: 專案目錄/sh
source .env

cd ..

# function obs_js_2_dist() {
#     module_name = $1
#     javascript-obfuscator $module_name/"$module_name.js"
#     mkdir -p dist/$module_name
#     cp $module_name/"$module_name-obfuscated.js" dist/$module_name/"$module_name.js"
#     rm $module_name/"$module_name-obfuscated.js"
# }

function compile_module() {
    module_name = $1
    cp -R $module_name dist/
    javascript-obfuscator dist/$module_name/"$module_name.js"
    rm dist/$module_name/"$module_name-obfuscated.js"
    cp dist/$module_name/"$module_name-obfuscated.js" dist/$module_name/"$module_name.js"
}


List=( 
    "cameo-divergent-stacked-bars" 
    "cameo-run" 
    "cameo-line" 
    "cameo-rank" 
    "cameo-multi-axis-prediction" 
    "cameo-map-tw" 
)

for Item in ${List[*]} 
  do
    compile_module "$Item"
  done

# function cp_app_module() {
#     module_name = $1
#     cp -R $module_name dist/
# }

# for Item in ${List[*]} 
#   do
#     cp_app_module "app-$Item"
#   done

cp -R app-* dist/
cp -R img dist/

cp iek-caraousel.html dist/
cp index.html dist/

