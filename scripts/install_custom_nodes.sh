#!/bin/bash
set -e

echo "==== Installing ComfyUI custom nodes ===="

cd /ComfyUI/custom_nodes

xargs -n 1 git clone --recursive < /custom_nodes.txt

find /ComfyUI/custom_nodes -name "requirements.txt" -exec pip install --no-cache-dir -r {} \;

find /ComfyUI/custom_nodes -name "install.py" -exec python {} \;

echo "==== Custom nodes installation complete ===="
