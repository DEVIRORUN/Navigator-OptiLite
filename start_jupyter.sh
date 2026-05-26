#!/bin/bash
# start_jupyter.sh - Run this every time you spin up the droplet
source /opt/navigator-env/bin/activate
cd /root/navigator-optilite
jupyter notebook --no-browser --ip=0.0.0.0 --port=8888
