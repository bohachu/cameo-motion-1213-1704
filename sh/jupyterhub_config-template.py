# https://jupyterhub.readthedocs.io/en/stable/api/auth.html#pamauthenticator
# Native Authenticator ref https://blog.jupyter.org/simpler-authentication-for-small-scale-jupyterhubs-with-nativeauthenticator-999534c77a09
# https://native-authenticator.readthedocs.io/en/latest/index.html
# https://github.com/jupyterhub/ldapauthenticator/issues/54
# To put this config in /opt/jupyterhub/etc/jupyterhub/jupyterhub_config.py, run:
 # sudo ./update_jupyterhub_config_then_restart.sh
from jupyter_client.localinterfaces import public_ips
import os

c.JupyterHub.admin_access = True

# c.JupyterHub.base_rul = ''
# c.JupyterHub.bind_url = 'http://127.0.0.1:3801/' 會失效, jhub無法連線
c.JupyterHub.bind_url = 'http://:3801/'
# c.Authenticator.admin_users = {'cameo','iek','cameo2','hanes','caro'}

c.LocalAuthenticator.create_system_users = True

def my_hook(authenticator, handler, authentication):
    # sample: https://jupyterhub.readthedocs.io/en/stable/api/auth.html
    the_user = authentication['name']
    str_cmd = f"sudo bash /root/admin_util/.post_add_admin.sh {the_user}"
    os.system(str_cmd)
    return authentication

c.Authenticator.post_auth_hook = my_hook

c.PAMAuthenticator.admin_groups = {'sudo'}
c.PAMAuthenticator.allowed_groups = {'sudo','analysts'}

# example [‘adduser’, ‘-q’, ‘–gecos’, ‘””’, ‘–home’, ‘/customhome/USERNAME’, ‘–disabled-password’]
# This will run the command:
# adduser -q –gecos “” –home /customhome/river –disabled-password river
# when the user ‘river’ is created.
c.PAMAuthenticator.add_user_cmd = ['sudo','bash','/root/admin_util/.add_user.sh']

# c.JupyterHub.ssl_key = '/var/ssl/private.key'
# c.JupyterHub.ssl_cert = '/var/ssl/certificate.crt'
# 需要先安裝並設定certbot
c.JupyterHub.ssl_key = '/etc/letsencrypt/live/iek.cameo.tw/privkey.pem'
c.JupyterHub.ssl_cert = '/etc/letsencrypt/live/iek.cameo.tw/fullchain.pem'

c.JupyterHub.cookie_secret_file = '/srv/jupyterhub/jupyterhub_cookie_secret'
c.Spawner.default_url = '/lab'


