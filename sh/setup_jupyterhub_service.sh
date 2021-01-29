#!/bin/bash
echo "Setup Jupyterhub systemd service"
source .env
sudo mkdir -p /opt/jupyterhub/etc/systemd
sudo /bin/cp /home/$USER/$PRJ_DIR_NAME/sh/jupyterhub.service /opt/jupyterhub/etc/systemd/jupyterhub.service
if [ -L /etc/systemd/system/jupyterhub.service ]; then
    sudo rm /etc/systemd/system/jupyterhub.service
fi
sudo ln -s /opt/jupyterhub/etc/systemd/jupyterhub.service /etc/systemd/system/jupyterhub.service
sudo chmod a+x /opt/jupyterhub/etc/systemd/jupyterhub.service
sudo systemctl daemon-reload
sudo systemctl enable jupyterhub.service
sudo systemctl start jupyterhub.service