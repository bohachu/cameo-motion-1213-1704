# Configuration file for jupyter-notebook.
# cp to /opt/jupyterhub/etc/jupyter/
# prerequisite: jupyterlab iframe extension

# jupyterlab iframe
# c.JupyterLabIFrame.iframes = ['list', 'of', 'sites']
import grp, pwd, getpass

the_user=getpass.getuser()

def is_the_user_in_the_group(the_user,thegroup='sudo'):
    groups = [g.gr_name for g in grp.getgrall() if the_user in g.gr_mem]
    gid = pwd.getpwnam(the_user).pw_gid
    groups.append(grp.getgrgid(gid).gr_name)
    if thegroup in groups:
        return True
    else:
        return False

is_user_sudo = is_the_user_in_the_group(the_user)
SITE_DOMAIN_PORT = 'https://iek.cameo.tw:3801'

def get_str_path_sysutil(the_user,is_user_sudo=False):
    str_url_voila_base = f'{SITE_DOMAIN_PORT}/user/{the_user}/voila/render'
    lst_iframes_base = []
    if is_user_sudo:        
        lst_iframes_base=[f'{str_url_voila_base}/管理者系統設定.ipynb']
    else:
        lst_iframes_base=[f'{str_url_voila_base}/系統設定.ipynb']

    lst_iframes_base.append(f'{str_url_voila_base}/my-web/my-web功能設定.ipynb')
    lst_iframes_base.append(f'{str_url_voila_base}/www/www功能設定.ipynb')

    return lst_iframes_base


def get_local_files(is_user_sudo=False):
    lst_local_files=[]
    if is_user_sudo:
        lst_local_files=['管理者系統設定.ipynb']        
    else:
        lst_local_files=['系統設定.ipynb']
    
    lst_local_files.append('my-web/my-web功能設定.ipynb')
    lst_local_files.append('www/www功能設定.ipynb')
    return lst_local_files

lst_path_sysutil = get_str_path_sysutil(the_user,is_user_sudo)
lst_local_file = get_local_files(is_user_sudo)

c.JupyterLabIFrame.iframes = lst_path_sysutil
# c.JupyterLabIFrame.welcome = 'a site to show on initial load'
c.JupyterLabIFrame.welcome = lst_path_sysutil[0]
# c.JupyterLabIFrame.local_files = ['list', 'of', 'local', 'html', 'files']
c.JupyterLabIFrame.local_files = lst_local_file

