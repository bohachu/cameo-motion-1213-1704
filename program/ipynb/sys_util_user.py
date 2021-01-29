import os, shutil, getpass
import ipywidgets as widgets
from ipywidgets import Button, Layout
# for 系統設定

def get_user_home_path():
    username=getpass.getuser()
    str_path_home = f'/home/{username}'
    return str_path_home

str_user_home_path = get_user_home_path()
button_myweb_reset = widgets.Button(description="my-web 回復原廠設定",layout=Layout(width='200px', height='40px'))
output_myweb_reset = widgets.Output()

def copytree(src, dst, symlinks=False, ignore=None):
    for item in os.listdir(src):
        if item == "my-web": # first item will be my-web which is folder name, but we don't want to create a folder name
            continue
        s = os.path.join(src, item)
        d = os.path.join(dst, item)
        if os.path.isdir(s):
            shutil.copytree(s, d, symlinks, ignore)
        else:
            shutil.copy2(s, d)

def backup_my_web():
    with output_myweb_reset:
        print("my-web 備份中...")

    # src_folder="./my-web"
    src_folder = os.path.join(str_user_home_path,"my-web")
    # original_folder_name="./history/my-web"
    original_folder_name=os.path.join(str_user_home_path,"history","my-web")
    # new_folder_name="./history/my-web"
    new_folder_name=os.path.join(str_user_home_path,"history","my-web")
    folder_duplicate_number=0
    while 1:
        if not os.path.exists(new_folder_name):
            os.makedirs(new_folder_name)
            break
        else:
            folder_duplicate_number+=1
            new_folder_name=original_folder_name+"-"+str(folder_duplicate_number)
    copytree(src_folder,new_folder_name)
       
    with output_myweb_reset:
        print("my-web 備份至"+new_folder_name)

def reset_my_web():
    with output_myweb_reset:
        print("my-web 重置中...")
    src_folder="/etc/skel/my-web"
    # new_folder_name="./my-web"
    new_folder_name = os.path.join(str_user_home_path,"my-web")

    if os.path.exists(new_folder_name):
        shutil.rmtree(new_folder_name)
    if not os.path.exists(new_folder_name):
        os.mkdir(new_folder_name)
    copytree(src_folder,new_folder_name)
    with output_myweb_reset:
        print("my-web 重置完成")

def on_button_clicked_myweb_reset(b):
    backup_my_web()
    reset_my_web()
