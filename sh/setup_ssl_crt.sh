#!/bin/bash
source .env

cd /home/$INSTALL_USER

sudo mkdir -p /var/ssl
# ssl_certificate 
if [ -f /home/$INSTALL_USER/$PRJ_DIR_NAME/secrets/certificate.crt ]; then
    sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/secrets/certificate.crt /var/ssl/certificate.crt
    echo "/var/ssl/certificate.crt 佈署完成!"
else 
    echo "警告:/home/$INSTALL_USER/$PRJ_DIR_NAME/secrets/certificate.crt 不存在請重新準備!"
fi
# ssl_certificate_key 
if [ -f /home/$INSTALL_USER/$PRJ_DIR_NAME/secrets/private.key ]; then
    sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/secrets/private.key /var/ssl/private.key
    echo "/var/ssl/private.key 佈署完成!"
else
    echo "警告:/home/$INSTALL_USER/$PRJ_DIR_NAME/secrets/private.key 不存在請重新準備!"
fi
# set permission of private key
# optional, but safer. Private keys then have group ssl-cert, owner root, and permissions 640.

sudo addgroup ssl-cert
# sudo adduser root ssl-cert
sudo usermod -a -G ssl-cert root
sudo chown root:ssl-cert /var/ssl/private.key
sudo chmod 600 /var/ssl/private.key
sudo chown root:ssl-cert /var/ssl/certificate.crt
sudo chmod 644 /var/ssl/certificate.crt

echo "設定SSL憑證... 完成!"