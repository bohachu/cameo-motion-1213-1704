# 檔案目錄架構
https://docs.google.com/spreadsheets/d/1tWdxukgrTkYYMxSWTksB98aDaiHLGq7kPeJgOC48TwY/edit#gid=0

# 更新library與meta.csv等檔案 

## 更新library與 meta.csv
目前release_dist_to_local_site.sh有備份既有檔案的功能。 
所以專案目錄下git pull後直接執行: 
cd sh 
001 sudo bash compile_and_release.sh 
這個會做: 
將網站打包到dist: 包含js加密和打包, 產出的網站檔案在dist 
發佈到網站目錄 , 包含備份既有目錄內容到/var/www/iek.cameo.tw/html_bak$date
發佈到預設使用者目錄 /etc/skel/myweb
發佈到admin_util 
發佈到user_util 

完成後逐使用者更新my-web:  
002 sudo bash release_my-web_to_that_user.sh $username

## 僅更新cameo-motion/lib/$lib_version檔案, 不更新.csv檔案 (所以不用備份) 
sudo bash compile_and_release_lib.sh 

# 安裝
### 001 取得git repo
cd 家目錄
git clone <repo網址> 

### 002 準備SSL憑證
安裝certbot:
(修改install_cerrtbot.sh中的domain name)
sudo ./install_cerrtbot.sh

完成後cert會在
ssl_certificate /etc/letsencrypt/live/iek.cameo.tw/fullchain.pem;
ssl_certificate_key /etc/letsencrypt/live/iek.cameo.tw/private.pem;

(obsolete)將private key和public key,和crt憑證 放置到專案目錄/secrets 目錄 下面

### 003 準備env檔案

cd sh

建立server環境設定檔, 如果不是第一次佈署, 需要檢查現有的.env是否所有key都一樣
cp .env-template .env

確認裡面的設定都符合環境, 
INIT_ADMIN_USER: 第一個使用者的名稱
INSTALL_USER: 本使用者名稱
PRJ_DIR_NAME: 專案目錄名稱, 安裝時會引用
SITE_DOMAIN: website domain name
HTML_DIR: 靜態網站檔案放置的位置
JS_LIB_VERSION: 版本號
其他為開發/安裝的參數, 比較試當時狀況

nano .env


建立使用者加目錄中的環境設定檔(因為ipynb需要用到)
cp etc_skel/.user-env-template etc_skel/.user-env
修改.env and .user-env檔案以符合情境 (主要是domain_name)


### 004 打包dist 並佈署到對應目錄
將網站發布到 HTML_DIR 目錄中
以及 HTML_DIR-bak目錄中 (還原原廠設定用途)

cd 專案目錄/sh 
安裝js-obfuscator
./install-js-obfuscator.sh

若修改程式碼後重新佈署時, compile以及發布www 和myweb要同時執行, 可執行:
./compile_and_release.sh 
(包含 compile,release_dist_to_local_site,release_dist_to_my-web,release_admin_util )


若compile, 以及發布www 和myweb需要獨立執行
compile dist, 包含js加密和打包, 產出的網站檔案在dist
sudo ./compile.sh

發佈到網站目錄
sudo ./release_dist_to_local_site.sh

發佈到預設使用者目錄
sudo ./release_dist_to_my-web.sh

發佈管理員工具
sudo ./release_admin_util.sh

應先將將舊的ipynb換成新的(WWW目錄以及/etc/skel中的)
sudo ./migrate_remove_old_ipynb.sh


不需要的使用者, 應先移除該使用者的超連結
sudo ./admin_util/.post_deluser.sh the_user

如果有更新jupyterhub_config.py
sudo ./update_jupyterhub_config_then_restart.sh

### 004.1 轉移既有使用者

轉移已經建立過的一般使用者 "that_user", 套用新的設定
sudo ./migrate_current_user_hide_user_html.sh that_user

轉移已經建立過的admin使用者 "that_user", 套用新的設定 (其中包含上述程式碼)
sudo ./migrate_current_admin_user_hide_admin_util_files.sh that_user


### 005 若重新佈署,僅更新既有使用者my-web檔案(不刪除)
sudo ./release_my-web_to_that_user.sh the_user

直接執行
sudo ./migrate_current_user_hide_user_html.sh that_user



### 005 安裝jupyterhub, jupyterlab, extension等主程式
第一次安裝server時需要安裝

cd 專案目錄/sh 
./install_server.sh

### 006 建立jupyterhub admin帳號
有兩種方法:

透過jupyterhub 介面建立使用者後
sudo ./admin_util/.post_add_admin_user.sh <username>
或如果jupyterhub admin要建立其他admin, 在該使用者home目錄可以用terminal執行
sudo ./.post_add_admin_user.sh <username>

不透過jupyterhub 介面
sudo ./admin_util/.add_admin_user.sh <username>
或如果jupyterhub admin要建立其他admin, 在該使用者home目錄可以用terminal執行
sudo ./.add_admin_user.sh <username>


說明:建立時OS會自動 從/etc/skel當作模板copy到此新增使用者加目錄
以及將必要的sh和program內的ipynb 複製過去使用者加目錄
然後設定好權限, 並且預設密碼與帳號一樣



### 007 建立一般使用者
有兩種方法:

Admin使用者透過jupyterhub 介面建立使用者後會自動執行.add_user.sh指令

若透過admin使用者的home目錄在terminal執行:
sudo bash .add_user.sh <username>
or
sudo bash /root/admin_util/.add_user.sh <username>

若需套用建立使用者後的行為, 則在admin家目錄:
sudo bash .post_add_user.sh <username>
or
sudo bash /root/admin_util/.post_add_user.sh <username>


### 008 密碼操作
設定個別使用者密碼:
sudo passwd <username>

使用者自行改密碼
passwd <username>

### 009 手動增加其他要建立使用者家目錄中的檔案
可以copy進 /etc/skel

在add_user 與 post_add_user, post_add_admin等過程會處理建立使用者目錄的過程

# 將Javascript 亂碼與壓縮說明
### 打包 js 
cd sh 
./compile-js.sh

操作紀錄見
https://www.notion.so/javascript-obfuscate-6cb870a822924c3bb59db57f09b8a693


## reference 
[https://miloserdov.org/?p=4767](https://miloserdov.org/?p=4767)

