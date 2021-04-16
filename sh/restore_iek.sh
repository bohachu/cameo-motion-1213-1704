#!/bin/bash
# working in user home

# decompress html to /var/www/iek.cameo.tw/html
sudo tar -xzvf iek_localsite.tar.gz -C /

# decompress my-web to  /home/iek/my-web
sudo tar -xzvf iek_my-web.tar.gz -C /

# decompress history to /home/iek/history
sudo tar -xzvf iek_history.tar.gz --overwrite -C /

