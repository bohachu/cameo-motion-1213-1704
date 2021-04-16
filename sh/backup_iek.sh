#!/bin/bash
# working in user home
# compile to zip 
# tar -czvf ~/Desktop/test.tar.gz ~/Desktop/testDir/
# backup history
tar -czvf iek_history.tar.gz /home/iek/history

# backup my-web
tar -czvf iek_my-web.tar.gz /home/iek/my-web

# backup html
tar -czvf iek_localsite.tar.gz /var/www/iek.cameo.tw/html

