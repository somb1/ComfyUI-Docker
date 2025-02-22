#!/bin/bash

export PYTHONUNBUFFERED=1

source /workspace/venv/bin/activate
cd /workspace/ComfyUI

echo "**** Displays the available arguments for running ComfyUI. ****" 
python main.py --help

echo "**** Starts ComfyUI, listening on port 3000, with additional arguments specified by COMFYUI_EXTRA_ARGS. ****"
python main.py --listen --port 3000 $COMFYUI_EXTRA_ARGS &
