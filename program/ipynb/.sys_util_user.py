import os, shutil, getpass
# for 系統設定

def get_user_home_path():
    username=getpass.getuser()
    str_path_home = f'/home/{username}'
    return str_path_home

str_user_home_path = get_user_home_path()

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

def backup_my_web(output_myweb_reset):
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

def reset_my_web(output_myweb_reset):
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

def on_button_clicked_myweb_reset(output_myweb_reset):
    backup_my_web(output_myweb_reset)
    reset_my_web(output_myweb_reset)


#######################
def on_button_clicked_app_cameo_run(output_app_cameo_run):
    src_folder="./components/app-cameo-run"
    folder_name="./app-cameo-run"
    check_folder_name="./app-cameo-run"
    folder_duplicate_number=0
    while 1:
        if not os.path.exists(check_folder_name):
            os.makedirs(check_folder_name)
            break
        else:
            folder_duplicate_number+=1
            check_folder_name=folder_name+"-"+str(folder_duplicate_number)
    copytree(src_folder,check_folder_name)
    copyIframeGeneratorToComponet(check_folder_name)
    with output_app_cameo_run:
        print(check_folder_name+" creating...")


def on_button_clicked_app_cameo_rank(output_app_cameo_rank):
    src_folder="./components/app-cameo-rank"
    folder_name="./app-cameo-rank"
    check_folder_name="./app-cameo-rank"
    folder_duplicate_number=0
    while 1:
        if not os.path.exists(check_folder_name):
            os.makedirs(check_folder_name)
            break
        else:
            folder_duplicate_number+=1
            check_folder_name=folder_name+"-"+str(folder_duplicate_number)
    copytree(src_folder,check_folder_name)
    copyIframeGeneratorToComponet(check_folder_name)
    with output_app_cameo_rank:
        print(check_folder_name+" creating...")

def on_button_clicked_app_cameo_multi_axis_prediction(output_app_cameo_multi_axis_prediction):
    src_folder="./components/app-cameo-multi-axis-prediction"
    folder_name="./app-cameo-multi-axis-prediction"
    check_folder_name="./app-cameo-multi-axis-prediction"
    folder_duplicate_number=0
    while 1:
        if not os.path.exists(check_folder_name):
            os.makedirs(check_folder_name)
            break
        else:
            folder_duplicate_number+=1
            check_folder_name=folder_name+"-"+str(folder_duplicate_number)
    copytree(src_folder,check_folder_name)
    copyIframeGeneratorToComponet(check_folder_name)
    with output_app_cameo_multi_axis_prediction:
        print(check_folder_name+" creating...")

def on_button_clicked_app_cameo_map_tw(output_app_cameo_map_tw):
    src_folder="./components/app-cameo-map-tw"
    folder_name="./app-cameo-map-tw"
    check_folder_name="./app-cameo-map-tw"
    folder_duplicate_number=0
    while 1:
        if not os.path.exists(check_folder_name):
            os.makedirs(check_folder_name)
            break
        else:
            folder_duplicate_number+=1
            check_folder_name=folder_name+"-"+str(folder_duplicate_number)
    copytree(src_folder,check_folder_name)
    copyIframeGeneratorToComponet(check_folder_name)
    with output_app_cameo_map_tw:
        print(check_folder_name+" creating...")

def on_button_clicked_cameo_app_cameo_line(output_cameo_app_cameo_line):
    src_folder="./components/app-cameo-line"
    folder_name="./app-cameo-line"
    check_folder_name="./app-cameo-line"
    folder_duplicate_number=0
    while 1:
        if not os.path.exists(check_folder_name):
            os.makedirs(check_folder_name)
            break
        else:
            folder_duplicate_number+=1
            check_folder_name=folder_name+"-"+str(folder_duplicate_number)
    copytree(src_folder,check_folder_name)
    copyIframeGeneratorToComponet(check_folder_name)
    with output_cameo_app_cameo_line:
        print(check_folder_name+" creating...")
        
def on_button_clicked_cameo_divergent_stacked_bars(output_app_cameo_divergent_stacked_bars):
    src_folder="./components/app-cameo-divergent-stacked-bars"
    folder_name="./app-cameo-divergent-stacked-bars"
    check_folder_name="./app-cameo-divergent-stacked-bars"
    folder_duplicate_number=0
    while 1:
        if not os.path.exists(check_folder_name):
            os.makedirs(check_folder_name)
            break
        else:
            folder_duplicate_number+=1
            check_folder_name=folder_name+"-"+str(folder_duplicate_number)
    copytree(src_folder,check_folder_name)
    copyIframeGeneratorToComponet(check_folder_name)
    with output_app_cameo_divergent_stacked_bars:
        print(check_folder_name+" creating...")



def copyIframeGeneratorToComponet(dist):
    shutil.copy2("/root/user_util/get-iframe.ipynb",dist)
    
# def copytree(src, dst, symlinks=False, ignore=None):
#     for item in os.listdir(src):
#         s = os.path.join(src, item)
#         d = os.path.join(dst, item)
#         if os.path.isdir(s):
#             shutil.copytree(s, d, symlinks, ignore)
#         else:
#             shutil.copy2(s, d)        


def on_button_clicked_get_iframe(output_get_iframe):
    with output_get_iframe:
        print("iframe 碼如下")
        dic_name= os.getcwd().split("/")
        print("<iframe frameborder=\"0\" src=\"https://iek.cameo.tw/."+dic_name[len(dic_name)-2]+"\" width=\"100%\" height=\"900\"></iframe>")



def on_button_clicked_get_preview(output_get_preview):
    with output_get_preview:
        print("預覽網址如下")
        #print("https://iek.cameo.tw/"+dic_name[len(dic_name)-2]+"/"+dic_name[len(dic_name)-1])
        dic_name= os.getcwd().split("/")
        print ("https://iek.cameo.tw/."+dic_name[len(dic_name)-2])    