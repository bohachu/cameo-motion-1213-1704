#!/bin/bash
# ref https://jupyterhub.readthedocs.io/en/stable/reference/config-user-env.html

source .env

echo "佈署env-wide jupyter_notebook_config.py..."

sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/jupyter_notebook_config.py /opt/jupyterhub/etc/jupyter/

sudo chown root:root /opt/jupyterhub/etc/jupyter/jupyter_notebook_config.py

sudo chmod 755 /opt/jupyterhub/etc/jupyter/jupyter_notebook_config.py

echo "佈署env-wide jupyter_notebook_config.py... 完成!"
