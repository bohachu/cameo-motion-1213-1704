# 安裝
### 001 取得git repo
cd 家目錄
git clone <repo網址> 

### 002 
將private key和public key放置到專案目錄/secrets 目錄 下面

### 003 準備env檔案
cd sh
cp .env-template .env
cp etc_skel/.user-env-template etc_skel/.user-env
修改.env and .user-env檔案以符合情境


### 004 打包dist
將網站發布到wwwhtml目錄中

cd 專案目錄/sh 
安裝js-obfuscator
./install-js-obfuscator.sh
compile dist
./compile.sh

發佈到網站目錄
./release_dist_to_local_site.sh

發佈到預設使用者目錄
./release_dist_to_my-web.sh

### 005 安裝主程式
cd 專案目錄/sh 
執行 ./install.sh


### 006 建立第一位jupyterhub admin帳號
./add_admin_user.sh <username>
./post_add_admin_user.sh <username>

可以設定個別使用者密碼
sudo passwd <username>

### 007 其他要建立使用者家目錄中的檔案
可以copy進 /etc/skel


# 將Javascript 搞亂與壓縮說明

## reference 
[https://miloserdov.org/?p=4767](https://miloserdov.org/?p=4767)

# sample

cameo-divergent-stacked-bars.js
cameo-run.js
cameo-line.js
cameo-rank.js
cameo-multi-axis-prediction.js
cameo-map-tw/cameo-map-tw.js


操作紀錄見
https://www.notion.so/javascript-obfuscate-6cb870a822924c3bb59db57f09b8a693


# 打包 js 
cd sh 
./compile-js.sh

