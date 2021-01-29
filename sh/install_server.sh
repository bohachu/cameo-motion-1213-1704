#!/bin/bash
# 起始執行目錄: 專案目錄/sh
# 請先把sh變成可以執行: chmod a+x *.sh
# 請先設定好nginx
# after install, launch with: 
# jupyterhub: sudo systemctl start jupyterhub.service or
#     /opt/jupyterhub/bin/jupyterhub -f /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
# jupyterhub設定檔: 專案目錄/sh/jupyter_config.py -> /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py
# 修改設定後重啟服務: ./update_jupyterhub_config_then_restart.sh
# nginx設定檔: cp 專案目錄/sh/nginx_http.conf
# 靜態網頁目錄: cp 專案目錄/src 
# cd /home/$USER/$PRJ_DIR_NAME/sh
# rm /home/$USER/$PRJ_DIR_NAME/sh/.env
chmod +x *.sh

echo "準備設定檔"

if [[ ! -f .env ]]; then
    echo "Copying environment template..."
    cp .env-template .env
    sudo chmod 600 .env
fi

if [[ ! -f etc_skel/.user-env ]]; then
    cp etc_skel/.user-env-template etc_skel/.user-env
fi
source .env

echo "設定時區為Taipei時區"
sudo timedatectl set-timezone Asia/Taipei

cd /home/$INSTALL_USER/

# conda ppa
echo "Add conda ppa and install conda."
curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor > conda.gpg
sudo install -o root -g root -m 644 conda.gpg /etc/apt/trusted.gpg.d/
sudo echo "deb [arch=amd64] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" | sudo tee /etc/apt/sources.list.d/conda.list
sudo apt update && sudo apt install conda --upgrade -y && \
    sudo apt clean -y && \
    sudo apt -y autoremove 

source ~/.bashrc
# # postgresql ppa
# wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
# sudo echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" |sudo tee  /etc/apt/sources.list.d/pgdg.list
# sudo apt install postgresql-12 postgresql-client-12  --upgrade -y

# vscode ppa
# curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
# sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
# sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
# sudo apt install apt-transport-https
# sudo apt update && sudo apt install code -y

# sudo /opt/jupyterhub/bin/python3 -m pip install keplergl opencv-python
# sudo ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime && \
# sudo add-apt-repository -y ppa:ubuntugis/ppa && \
echo "Install system libraries."
sudo apt update && \
    sudo apt install --upgrade -y \
    python3 python3-dev  python3-venv \
    curl wget sudo cron joe nano \
    zip unzip file fonts-dejavu acl libpq-dev \
    sqlite3
    
sudo apt install --upgrade -y \
    apt-utils ffmpeg libssl1.1 libssl-dev \
    libxtst6 xvfb xdotool wmctrl cmake \
    tzdata graphviz graphviz-dev \
    libxml2-dev libxslt-dev libjpeg-dev zlib1g-dev libpng-dev  \
    software-properties-common 

sudo apt install git-lfs mc nginx && \
    sudo export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/local/lib && \
    sudo apt clean -y && \
    sudo apt -y autoremove 

# sudo add-apt-repository -y ppa:ubuntugis/ppa

sudo apt install nodejs npm -y && \
    sudo apt clean -y && \
    sudo apt -y autoremove 

source ~/.bashrc
cd /home/$INSTALL_USER/$PRJ_DIR_NAME/sh

echo "安裝Install Python3, Jupyterhub, Jupyterlab 等..."
sudo bash /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/install_jhub_lab.sh

source ~/.bashrc

# Setup Systemd service
sudo bash /home/$INSTALL_USER/$PRJ_DIR_NAME/shsetup_jupyterhub_service.sh
# sudo rm -rf /var/lib/apt/lists/*

echo "SSL憑證設定"
sudo bash /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/setup_ssl_crt.sh

echo "nginx 安裝啟動設定"
sudo bash /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/setup_nginx.sh

echo "新使用者建立時的預設設定 (其他手動建立的行為請見.post_add_user.sh)"
sudo bash /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/setup_default_useradd.sh

source ~/.bashrc

echo "準備admin維護工具"
sudo bash /home/$INSTALL_USER/$PRJ_DIR_NAME/sh/release_admin_util.sh

echo "建立起始admin帳號"
sudo bash /root/admin_util/add_admin_user.sh $INIT_ADMIN_USER

# /usr/local/bin/julia -e 'import Pkg; Pkg.add("IJulia"); Pkg.build("IJulia"); using IJulia; notebook(detached=true);'

# ## install julia
# cd ~
# wget https://julialang-s3.julialang.org/bin/linux/x64/1.5/julia-1.5.3-linux-x86_64.tar.gz
# tar xvfz julia-1.5.3-linux-x86_64.tar.gz
# sudo chown -R root:users ~/julia-1.5.3/
# # sudo chmod a+x ~/julia-1.5.3/bin/
# # cd /usr/local/bin/
# sudo ln -s ~/julia-1.5.3/bin/julia /usr/local/bin/julia

source ~/.bashrc



## jupyterlab julia 
# /usr/local/bin/julia -e 'import Pkg; Pkg.add("IJulia"); Pkg.build("IJulia"); using IJulia; notebook(detached=true);'

# ## install julia genie
# /usr/local/bin/julia -e 'import Pkg; Pkg.add("PackageCompiler");using PackageCompiler;Pkg.add("Genie");@time using Genie;@time PackageCompiler.create_sysimage(:Genie; replace_default=true)'

# ## interact.jl
# /usr/local/bin/julia -e 'using Pkg;Pkg.add("Interact");Pkg.add("IJulia");Pkg.add("WebIO")'
# /usr/local/bin/julia -e 'using WebIO; using Interact; WebIO.install_jupyter_labextension();'

# ## deno
# cd ~
# curl -fsSL https://deno.land/x/install/install.sh | sh
# # cd /usr/local/bin/

# ## github
# git config --global user.email "$DEFAULT_GIT_USER_EMAIL"
# git config --global user.name "$DEFAULT_GIT_USER_NAME"
# git config --global credential.helper cache
# git config --global credential.helper store

source ~/.bashrc
echo "設定完成!"

