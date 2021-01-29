import os, shutil, getpass
import ipywidgets as widgets
# for my-web功能設定

btn_width='300px'
btn_height='40px'

button_app_cameo_divergent_stacked_bars = widgets.Button(description="創建 app-cameo-divergent-stacked-bars 目錄",layout=Layout(width=btn_width, height=btn_height))
output_app_cameo_divergent_stacked_bars = widgets.Output()

button_app_cameo_run = widgets.Button(description="創建 app-cameo-run 目錄",layout=Layout(width=btn_width, height=btn_height))
output_app_cameo_run = widgets.Output()

button_cameo_app_cameo_line = widgets.Button(description="創建 app-cameo-line 目錄",layout=Layout(width=btn_width, height=btn_height))
output_cameo_app_cameo_line = widgets.Output()

button_app_cameo_rank = widgets.Button(description="創建 app-cameo-rank 目錄",layout=Layout(width=btn_width, height=btn_height))
output_app_cameo_rank = widgets.Output()

button_app_cameo_multi_axis_prediction = widgets.Button(description="創建 app-cameo-multi-axis-prediction 目錄",layout=Layout(width=btn_width, height=btn_height))
output_app_cameo_multi_axis_prediction = widgets.Output()

button_app_cameo_map_tw = widgets.Button(description="創建 app-cameo-map-tw 目錄",layout=Layout(width=btn_width, height=btn_height))
output_app_cameo_map_tw = widgets.Output()

button_get_iframe = widgets.Button(description="取得 iframe 碼",layout=Layout(width='200px', height='40px'))
output_get_iframe = widgets.Output()

button_get_preview = widgets.Button(description="取得預覽網址",layout=Layout(width='200px', height='40px'))
output_get_preview = widgets.Output()

def check_folder_name_duplicate(folder_name, check_folder_name):
    folder_duplicate_number=0
    while 1:
        if not os.path.exists(check_folder_name):
            os.makedirs(check_folder_name)
            break
        else:
            folder_duplicate_number+=1
            check_folder_name=folder_name+"-"+str(folder_duplicate_number)
    return check_folder_name

def copyIframeGeneratorToComponet(dist):
    shutil.copy2("/root/user_util/get-iframe.ipynb",dist)

def on_button_clicked_app_cameo_run():
    src_folder="./components/app-cameo-run"
    folder_name="./app-cameo-run"
    check_folder_name="./app-cameo-run"
    check_folder_name = check_folder_name_duplicate(folder_name, check_folder_name)
    copytree(src_folder,check_folder_name)
    copyIframeGeneratorToComponet(check_folder_name)
    with output_app_cameo_run:
        print(check_folder_name+" creating...")


def on_button_clicked_app_cameo_rank():
    src_folder=os.path.join(str_user_home_path,"components","app-cameo-rank")
    # src_folder="./components/app-cameo-rank"
    # folder_name="./app-cameo-rank"
    folder_name=os.path.join(str_user_home_path,"app-cameo-rank")
    # check_folder_name="./app-cameo-rank"
    check_folder_name=os.path.join(str_user_home_path,"app-cameo-rank")
    check_folder_name = check_folder_name_duplicate(folder_name, check_folder_name)
    copytree(src_folder,check_folder_name)
    copyIframeGeneratorToComponet(check_folder_name)
    with output_app_cameo_rank:
        print(check_folder_name+" creating...")

def on_button_clicked_app_cameo_multi_axis_prediction():
    src_folder="./components/app-cameo-multi-axis-prediction"
    folder_name="./app-cameo-multi-axis-prediction"
    check_folder_name="./app-cameo-multi-axis-prediction"
    check_folder_name = check_folder_name_duplicate(folder_name, check_folder_name)
    copytree(src_folder,check_folder_name)
    copyIframeGeneratorToComponet(check_folder_name)
    with output_app_cameo_multi_axis_prediction:
        print(check_folder_name+" creating...")

def on_button_clicked_app_cameo_map_tw():
    src_folder="./components/app-cameo-map-tw"
    folder_name="./app-cameo-map-tw"
    check_folder_name="./app-cameo-map-tw"
    check_folder_name = check_folder_name_duplicate(folder_name, check_folder_name)
    copytree(src_folder,check_folder_name)
    copyIframeGeneratorToComponet(check_folder_name)
    with output_app_cameo_map_tw:
        print(check_folder_name+" creating...")

def on_button_clicked_cameo_app_cameo_line():
    src_folder="./components/app-cameo-line"
    folder_name="./app-cameo-line"
    check_folder_name="./app-cameo-line"
    check_folder_name = check_folder_name_duplicate(folder_name, check_folder_name)
    copytree(src_folder,check_folder_name)
    copyIframeGeneratorToComponet(check_folder_name)
    with output_cameo_app_cameo_line:
        print(check_folder_name+" creating...")
        
def on_button_clicked_cameo_divergent_stacked_bars():
    src_folder="./components/app-cameo-divergent-stacked-bars"
    folder_name="./app-cameo-divergent-stacked-bars"
    check_folder_name="./app-cameo-divergent-stacked-bars"
    check_folder_name = check_folder_name_duplicate(folder_name, check_folder_name)
    copytree(src_folder,check_folder_name)
    copyIframeGeneratorToComponet(check_folder_name)
    with output_app_cameo_divergent_stacked_bars:
        print(check_folder_name+" creating...")

   
def copytree(src, dst, symlinks=False, ignore=None):
    for item in os.listdir(src):
        s = os.path.join(src, item)
        d = os.path.join(dst, item)
        if os.path.isdir(s):
            shutil.copytree(s, d, symlinks, ignore)
        else:
            shutil.copy2(s, d)        


def on_button_clicked_get_iframe():
    with output_get_iframe:
        print("iframe 碼如下")
        dic_name= os.getcwd().split("/")
        print("<iframe frameborder=\"0\" src=\"https://iek.cameo.tw/."+dic_name[len(dic_name)-2]+"\" width=\"100%\" height=\"900\"></iframe>")

def on_button_clicked_get_preview():
    with output_get_preview:
        print("預覽網址如下")
        #print("https://iek.cameo.tw/"+dic_name[len(dic_name)-2]+"/"+dic_name[len(dic_name)-1])
        dic_name= os.getcwd().split("/")
        print ("https://iek.cameo.tw/."+dic_name[len(dic_name)-2])    