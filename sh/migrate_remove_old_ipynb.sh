#!/bin/bash

#處理 ipynb更名
function remove_if_exists() {
    local filepath=$1
    if [ -f $filepath ]; then
        sudo rm -f $filepath
        echo "sudo rm -f $filepath ...done!"
    fi
}
# 移除既有 my-web下 .ipynb
List=( "get-myweb-iframe.ipynb" "get-iframe.ipynb" "fork-component.ipynb" "get-preview-address.ipynb" )
# cd /etc/skel/my-web
for Item in ${List[*]} 
    do    
        remove_if_exists /etc/skel/my-web/$Item    
    done

remove_if_exists /etc/skel/settings.ipynb

function remove_html_ipynb(){
    local folderpath=$1
    local List2=( "get_iframe.ipynb" "get-www-iframe.ipynb" )
    for Item in ${List2[*]} 
        do
            remove_if_exists $folderpath/$Item
        done
}

remove_html_ipynb $HTML_DIR
remove_html_ipynb $HTML_DIR-bak