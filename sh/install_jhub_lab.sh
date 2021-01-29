#!/bin/bash

source .env

echo "Install Python3, Jupyterhub, Jupyterlab libraries."
sudo python3 -m venv /opt/jupyterhub/
sudo /opt/jupyterhub/bin/python3 -m pip install --upgrade pip --no-cache-dir 
sudo /opt/jupyterhub/bin/python3 -m pip install \
    wheel jupyterhub jupyterlab ipywidgets  \
    nbgitpuller voila voila-gridstack  \
    nbgitpuller google-cloud-storage pandas scikit-learn widgetsnbextension \
    pandas matplotlib ipympl numba numexpr xlrd psycopg2 jupyterlab_iframe \
    --no-cache-dir

# pip install 
# "matplotlib==3.3.2" \
#     "scipy==1.5.3" \
#     "numba==0.52" \
#     "numexpr==2.7.1" \
#     "psycopg2==2.8.6" \
#     "xlrd==1.2" \
#     "pandas==1.1.4" \
#     "ipympl==0.5.8" \
# jupyterhub-nativeauthenticator ipyleaflet

cd /home/$INSTALL_USER
sudo npm install -g configurable-http-proxy -y


sudo mkdir -p /opt/jupyterhub/etc/jupyterhub/
# cd /opt/jupyterhub/etc/jupyterhub/
# sudo echo "deb [arch=amd64] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" | sudo tee /etc/apt/sources.list.d/conda.list

# Create the configuration for JupyterHub
# sudo /opt/jupyterhub/bin/jupyterhub --generate-config
echo "Prepare jupyterhub_confug.py"
if [ -f /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py ]; then
    sudo mv /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py /opt/jupyterhub/etc/jupyterhub/jupyterhub_config-bak.py
fi
if [ ! -f /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/jupyterhub_config.py ]; then
    cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/jupyterhub_config-template.py /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/jupyterhub_config.py
fi
sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/jupyterhub_config.py /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
sudo chmod a+x /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
echo "Prepare jupyterhub_confug.py ...Done!"

# userlist
echo "Prepare userlist"
cd /home/$INSTALL_USER/$PRJ_DIR_NAME/sh
if [[ ! -f userlist ]]; then
    echo "Copying environment template..."
    cp userlist-template userlist
fi
sudo /bin/cp /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/userlist /opt/jupyterhub/etc/jupyterhub/userlist


# Part II: Conda Environments
# 安裝使用者環境
# 會將conda安裝在 /opt/conda/; 指令會在 /opt/conda/bin/conda
echo "Setup user environment in Jupyterlab."
sudo ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh
sudo mkdir -p /opt/conda/envs/

# Install a default conda environment for all users
sudo /opt/conda/bin/conda install -c conda-forge -y 'conda-build' && \
    sudo /opt/conda/bin/conda config --prepend channels conda-forge

# 建立conda env 同時安裝libraries
# 將jupyterhub內的conda env 放在為jupyterhub安裝的虛擬環境中
sudo /opt/conda/bin/conda create --prefix /opt/conda/envs/python python=3.7 ipykernel 
# 增加jupyter運算核心

sudo /opt/conda/envs/python/bin/python3 -m ipykernel install --prefix=/opt/jupyterhub/ --name 'python' --display-name "Python 3 (default)"
# 會遇到下列訊息, 日後還有問題有需要可以著手處理
#[InstallIPythonKernelSpecApp] WARNING | Installing to /opt/jupyterhub/share/jupyter/kernels, 
# which is not in ['/root/.local/share/jupyter/kernels', '/opt/conda/envs/python/share/jupyter/kernels', '/usr/local/share/jupyter/kernels', '/usr/share/jupyter/kernels', '/root/.ipython/kernels']. 
# The kernelspec may not be found.
# Installed kernelspec python in /opt/jupyterhub/share/jupyter/kernels/python

# 安裝到使用者的env...但是很像沒有作用
# sudo /opt/conda/bin/conda install -p /opt/jupyterhub/ \
sudo /opt/conda/bin/conda install -p /opt/conda/envs/python \
    -c conda-forge \
    "nodejs>=12.4" \
    "icu==58.2" \
    "python-libarchive-c==2.9" \
    "conda-package-handling" \
    "libarchive==3.5" \
    "ipywidgets==7.5.1" \
    "widgetsnbextension==3.5.1" \
    "matplotlib==3.3.2" \
    "scipy==1.5.3" \
    "numba==0.52" \
    "numexpr==2.7.1" \
    "psycopg2==2.8.6" \
    "xlrd==1.2" \
    "pandas==1.1.4" \
    "ipympl==0.5.8" \
    "nbgitpuller==0.9" \
    "voila==0.2.4" \
    "voila-gridstack==0.0.12" \
    "psutil==5.7.3" \
    "google-cloud-storage" \
    "nose==1.3.7" \
    "scikit-learn==0.23.2" \
    -y 

# "ipyleaflet==0.13.3" 

# "jupyterhub=$JUPYTERHUB_VERSION" \
# "jupyterlab=$JUPYTERLAB_VERSION" \
# "notebook=$NOTEBOOK_VERSION" \
#cv2 not available
sudo /opt/conda/envs/python/bin/python -m pip install --upgrade pip --no-cache-dir 
# sudo /opt/conda/envs/python/bin/pip3 install keplergl --no-cache-dir 


sudo chmod -R a+w /opt/conda/ && \
    sudo chown -R root:users /opt/conda && \
    sudo chmod g+s /opt/conda

sudo /opt/conda/bin/conda build purge-all && \
    sudo /opt/conda/bin/conda clean --all -f -y && \
    sudo rm -fvR /opt/conda/pkgs/*

echo "安裝和啟用jupyterlab/jupyter notebook 外掛."
export NODE_OPTIONS=--max-old-space-size=4096 #&& \
sudo /opt/jupyterhub/bin/jupyter serverextension enable --py jupyterlab --sys-prefix #&& \
sudo /opt/jupyterhub/bin/jupyter serverextension enable voila --sys-prefix #&& \
sudo /opt/jupyterhub/bin/jupyter nbextension install --py widgetsnbextension --sys-prefix #&& \
sudo /opt/jupyterhub/bin/jupyter nbextension enable widgetsnbextension --py --sys-prefix #&& \
sudo /opt/jupyterhub/bin/jupyter labextension install @jupyter-widgets/jupyterlab-manager --no-build #&& \
sudo /opt/jupyterhub/bin/jupyter labextension install jupyterlab_filetree --no-build #&& \
sudo /opt/jupyterhub/bin/jupyter labextension install @jupyter-widgets/jupyterlab-sidecar --no-build #&& \
sudo /opt/jupyterhub/bin/jupyter labextension install @jupyterlab/geojson-extension --no-build #&& \
sudo /opt/jupyterhub/bin/jupyter labextension install spreadsheet-editor --no-build #&& \
sudo /opt/jupyterhub/bin/jupyter labextension install @jupyter-voila/jupyterlab-preview --no-build #&& \
sudo /opt/jupyterhub/bin/jupyter labextension install jupyterlab_iframe  --no-build #&& \
sudo /opt/jupyterhub/bin/jupyter serverextension enable --py jupyterlab_iframe #&& \
sudo /opt/jupyterhub/bin/jupyter lab clean #&& \
sudo /opt/jupyterhub/bin/jupyter lab build --dev-build=False #&& \
unset NODE_OPTIONS 
# 移除 --minimize=False 會進一步加速,但是如果記憶體不足則會出現runtime error
# sudo /opt/jupyterhub/bin/jupyter labextension install @jupyter-widgets/jupyterlab-manager keplergl-jupyter --no-build && \
# sudo /opt/jupyterhub/bin/jupyter labextension install jupyter-matplotlib --no-build && \ 
# sudo /opt/jupyterhub/bin/jupyter nbextension enable --py --sys-prefix ipyleaflet && \
# sudo /opt/jupyterhub/bin/jupyter labextension install @jupyter-widgets/jupyterlab-manager jupyter-leaflet --no-build && \
    # jupyter labextension install jupyterlab-plotly@4.6.0 --no-build && \
    # jupyter labextension install plotlywidget@4.6.0 --no-build && \
source ~/.bashrc

cd /home/$INSTALL_USER/$PRJ_DIR_NAME/sh

echo "建立env-wide jupyter_notebook_config.py"
sudo bash /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/release_jupyternb_config.sh

echo "建立jupyterhub_cookie_secret"
sudo bash /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/refresh_jupyterhub_cookie_secret.sh

source ~/.bashrc

echo "安裝Python3, Jupyterhub, Jupyterlab 等...完成!"