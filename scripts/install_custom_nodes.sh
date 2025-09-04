#!/bin/bash

echo "==== Installing ComfyUI custom nodes ===="

cd /workspace/ComfyUI/custom_nodes

xargs -n 1 git clone --recursive < /custom_nodes.txt

find /workspace/ComfyUI/custom_nodes -name "requirements.txt" -exec pip install --no-cache-dir -r {} \;

find /workspace/ComfyUI/custom_nodes -name "install.py" -exec python {} \;

echo "==== Custom nodes installation complete ===="
