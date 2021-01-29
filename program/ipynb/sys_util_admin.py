import os, shutil
from distutils import dir_util
from ipywidgets import Button, Layout
import getpass

import ipywidgets as widgets


def get_user_home_path():
    username=getpass.getuser()
    str_path_home = f'/home/{username}'
    return str_path_home

str_user_home_path=get_user_home_path()

button_www_reset = widgets.Button(description="www 回復原廠設定",layout=Layout(width='200px', height='40px'))
output_www_reset = widgets.Output()


button_myweb_reset = widgets.Button(description="my-web 回復原廠設定",layout=Layout(width='200px', height='40px'))
output_myweb_reset = widgets.Output()


def www_copytree(src, dst, symlinks=False, ignore=None):
    for item in os.listdir(src):
        print("item = "+item)
        if item == "my-web": # first item will be my-web which is folder name, but we don't want to create a folder name
            continue
        if item == "www功能設定.ipynb":
            continue
        s = os.path.join(src, item)
        d = os.path.join(dst, item)
        if os.path.islink(s): # dont copy if it is a symbolic link
            continue
        if os.path.isdir(s):
            #shutil.copytree(s, d, symlinks,  ignore=shutil.ignore_patterns('.*')) #my-web copy using this
            dir_util.copy_tree(s,d) # www copy using this
        else:
            #shutil.copy2(s, d)
            shutil.copyfile(s, d)

def backup_www():
    with output_www_reset:
        print("www 備份中...")
    # str_user_home_path=get_user_home_path()
    src_folder=os.path.join(str_user_home_path,"www")
    # original_folder_name="./history/www"
    original_folder_name = os.path.join(str_user_home_path,"history","www")
    new_folder_name=os.path.join(str_user_home_path,"history","www")
    folder_duplicate_number=0
    print("test")
    while 1:
        if not os.path.exists(new_folder_name):
            print("if")
            print(new_folder_name)
            os.makedirs(new_folder_name)
            break
        else:

            folder_duplicate_number+=1
            new_folder_name=original_folder_name+"-"+str(folder_duplicate_number)
            print("else")
            print(new_folder_name)
    www_copytree(src_folder,new_folder_name)
       
    with output_www_reset:
        print("www 備份完成")

    
def reset_www():
    with output_myweb_reset:
        print("www 重置中...")
    src_folder="/var/www/iek.cameo.tw/html-bak"
    # str_user_home_path = get_user_home_path()
    new_folder_name=os.path.join(str_user_home_path,"history","www")
    # new_folder_name="./www"

#     if os.path.exists(new_folder_name):
#        shutil.rmtree(new_folder_name)
    www_copytree(src_folder,new_folder_name)
    with output_myweb_reset:
        print("www 重置完成")

def on_button_clicked_www_reset(b):
    backup_www()
    reset_www()

def myweb_copytree(src, dst, symlinks=False, ignore=None):
    for item in os.listdir(src):
        print("item = "+item)
        if item == "my-web": # first item will be my-web which is folder name, but we don't want to create a folder name
            continue
        if item == "www功能設定.ipynb":
            continue
        s = os.path.join(src, item)
        d = os.path.join(dst, item)
        if os.path.islink(s): # dont copy if it is a symbolic link
            continue
        if os.path.isdir(s):
            shutil.copytree(s, d, symlinks,  ignore=shutil.ignore_patterns('.*')) #my-web copy using this
            #dir_util.copy_tree(s,d) # www copy using this
        else:
            shutil.copy2(s, d)
            #shutil.copyfile(s, d)


def reset_my_web():
    with output_myweb_reset:
        print("my-web 重置中...")
    src_folder="/etc/skel/my-web"

    # str_user_home_path = get_user_home_path()
    # new_folder_name="./my-web"
    new_folder_name=os.path.join(str_user_home_path,"history","my-web")

    if os.path.exists(new_folder_name):
        shutil.rmtree(new_folder_name)
    if not os.path.exists(new_folder_name):
        os.mkdir(new_folder_name)
    myweb_copytree(src_folder,new_folder_name)
    with output_myweb_reset:
        print("my-web 重置完成")


def backup_my_web():
    with output_myweb_reset:
        print("my-web 備份中...")
    str_user_home_path = get_user_home_path()
    src_folder = os.path.join(str_user_home_path,"my-web")
    # src_folder="./my-web"
    # original_folder_name="./history/my-web"
    original_folder_name = os.path.join(str_user_home_path,"history","my-web")
    # new_folder_name="./history/my-web"
    new_folder_name = os.path.join(str_user_home_path,"history","my-web")
    folder_duplicate_number=0
    while 1:
        if not os.path.exists(new_folder_name):
            os.makedirs(new_folder_name)
            break
        else:
            folder_duplicate_number+=1
            new_folder_name=original_folder_name+"-"+str(folder_duplicate_number)
    myweb_copytree(src_folder,new_folder_name)
       
    with output_myweb_reset:
        print("my-web 備份至"+new_folder_name)

def on_button_clicked_myweb_reset(b):
    backup_my_web()
    reset_my_web()
