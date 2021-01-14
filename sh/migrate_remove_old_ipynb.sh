#!/bin/bash

#處理 ipynb更名

function remove_if_exists() {
    local filepath=$1
    if [ -f $filepath ]; then
        sudo rm -f $filepath
        echo "sudo rm -f $filepath ...done!"
    fi
}

remove_if_exists /etc/skel/settings.ipynb


# 移除既有 /etc/skel/my-web下 .ipynb
List=( "get-myweb-iframe.ipynb" "get-iframe.ipynb" "fork-component.ipynb" "get-preview-address.ipynb" )
# cd /etc/skel/my-web


function remove_my-web_ipynb(){
    local list=$1
    for Item in ${list[*]} 
    do    
        remove_if_exists /etc/skel/my-web/$Item    
    done
}
remove_my-web_ipynb $List

List2=( "get_iframe.ipynb" "get-www-iframe.ipynb" )

function remove_html_ipynb(){
    local folderpath=$1
    echo "folderpath=$folderpath"
    local list=$2
    for Item in ${list[*]} 
        do
            remove_if_exists $folderpath/$Item
            echo "remove_if_exists $folderpath/$Item"
        done
}

remove_html_ipynb $HTML_DIR $List2
remove_html_ipynb $HTML_DIR-bak $List2