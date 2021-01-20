#!/bin/bash

sudo /opt/jupyterhub/bin/jupyter nbextension disable --py --sys-prefix ipyleaflet
sudo /opt/jupyterhub/bin/jupyter labextension uninstall jupyter-leaflet
sudo /opt/jupyterhub/bin/jupyter labextension uninstall keplergl-jupyter
sudo /opt/jupyterhub/bin/jupyter labextension uninstall jupyter-matplotlib 
sudo /opt/jupyterhub/bin/jupyter lab clean