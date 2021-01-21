#!/bin/bash
export NODE_OPTIONS=--max-old-space-size=4096
sudo /opt/jupyterhub/bin/jupyter nbextension disable --py --sys-prefix ipyleaflet
sudo /opt/jupyterhub/bin/jupyter labextension uninstall jupyter-leaflet
sudo /opt/jupyterhub/bin/jupyter labextension uninstall keplergl-jupyter
sudo /opt/jupyterhub/bin/jupyter labextension uninstall jupyter-matplotlib 
sudo /opt/jupyterhub/bin/jupyter lab clean
sudo /opt/jupyterhub/bin/jupyter lab build --dev-build=False 
unset NODE_OPTIONS 
#--minimize=False 