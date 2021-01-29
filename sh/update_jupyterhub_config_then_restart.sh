#!/bin/bash
# in 專案目錄/sh/
# cd /home/$USER/cameo_motion/sh
# if [[ ! -f .env ]]; then
#     echo "Copying environment template..."
#     cp .env-template .env
# fi

source .env

sudo systemctl stop jupyterhub.service
if [ -f /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py ]; then
    sudo mv /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py /opt/jupyterhub/etc/jupyterhub/jupyterhub_config-bak.py
fi
if [ ! -f /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/jupyterhub_config.py ]; then
    cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/jupyterhub_config-template.py /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/jupyterhub_config.py
fi
sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/jupyterhub_config.py /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
sudo chmod +x /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
sudo systemctl start jupyterhub.service