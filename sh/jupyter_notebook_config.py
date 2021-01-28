# Configuration file for jupyter-notebook.
# in /home/$USER/.jupyter/jupyter_notebook_config.py
# prerequisite: jupyterlab iframe extension

# jupyterlab iframe
# c.JupyterLabIFrame.iframes = ['list', 'of', 'sites']
import getpass
the_user=getpass.getuser()
str_path_sysadminutil=f'https://iek-dev2.cameo.tw:3801/user/{the_user}/voila/render/管理者系統設定.ipynb'
c.JupyterLabIFrame.iframes = [str_path_sysadminutil]
# c.JupyterLabIFrame.welcome = 'a site to show on initial load'
c.JupyterLabIFrame.welcome = str_path_sysadminutil
# c.JupyterLabIFrame.local_files = ['list', 'of', 'local', 'html', 'files']

