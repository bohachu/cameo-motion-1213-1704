#!/bin/bash

#處理 ipynb更名

source .env

function remove_if_exists() {
    local filepath=$1
    if [ -f $filepath ]; then
        sudo rm -f $filepath
        echo "sudo rm -f $filepath ...done!"
    fi
}

remove_if_exists /etc/skel/settings.ipynb

# ref https://askubuntu.com/questions/674333/how-to-pass-an-array-as-function-argument
function remove_folder_ipynb() {
    local folderpath="$1"
    local List=( "get-myweb-iframe.ipynb" "get-iframe.ipynb" "fork-component.ipynb" "get-preview-address.ipynb" "fork_component.ipynb" "get_preview_address.ipynb" "get_iframe.ipynb" )
    for Item in ${List[*]};
        do  
            echo "Removing $folderpath/$Item"  
            remove_if_exists $folderpath/$Item
        done
}
echo "移除既有 /etc/skel/my-web下 舊ipynb"

# cd /etc/skel/my-web

remove_folder_ipynb /etc/skel/my-web "${List[@]}"


function remove_folder_ipynbㄉ() {
    local folderpath="$1"
    local List2=( "get_iframe.ipynb" "get-www-iframe.ipynb" )
    for Item in ${List2[*]};
        do  
            echo "Removing $folderpath/$Item"  
            remove_if_exists $folderpath/$Item
        done
}
echo "移除 $HTML_DIR and $HTML_DIR-bak 舊ipynb"

remove_folder_ipynb2 $HTML_DIR
remove_folder_ipynb2 $HTML_DIR-bak

echo "移除完成"
