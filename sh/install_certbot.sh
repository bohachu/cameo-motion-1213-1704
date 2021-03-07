# https://certbot.eff.org/docs/install.html
# https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-20-04
# 需要先準備好sudo nano /etc/nginx/sites-available/iek.cameo.tw 中的server block server_name iek.cameo.tw;
sudo apt install certbot python3-certbot-nginx

sudo certbot --nginx -d iek.cameo.tw