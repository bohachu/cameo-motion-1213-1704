#!/bin/bash
# for ubuntu/debia/kali

sudo apt install npm
sudo npm install --save-dev javascript-obfuscator
sudo ln -s ~/node_modules/javascript-obfuscator/bin/javascript-obfuscator /usr/local/bin

echo "Excample: javascript-obfuscator 檔案名稱.js"
