#!/bin/bash

export PYTHONUNBUFFERED=1

echo "**** syncing venv to workspace, please wait. This could take a while on first startup! ****"
rsync -au --remove-source-files /venv/ /workspace/venv/ && rm -rf /venv

# /venv -> /workspace/venv 문자열 변경 작업 수행
TARGET_DIR="/workspace"

echo "**** Replacing '/venv' with '/workspace/venv' in text files ****"
find "$TARGET_DIR" -type f | while read -r file; do
    if file "$file" | grep -q "text"; then
        sed -i 's|/venv|/workspace/venv|g' "$file"
        echo "Updated: $file"
    fi
done

echo "**** syncing ComfyUI to workspace, please wait ****"
rsync -au --remove-source-files /ComfyUI/ /workspace/ComfyUI/ && rm -rf /ComfyUI
rsync -au --remove-source-files /comfy-models/ /workspace/ComfyUI/models/ && rm -rf /ComfyUI /comfy-models

source /workspace/venv/bin/activate
cd /workspace/ComfyUI
python main.py --help
python main.py --listen --port 3000 $COMFYUI_EXTRA_ARGS &
