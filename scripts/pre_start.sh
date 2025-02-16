#!/bin/bash

export PYTHONUNBUFFERED=1

echo "**** syncing venv to workspace, please wait. This could take a while on first startup! ****"
rsync -au --remove-source-files /venv/ /workspace/venv/ && rm -rf /venv
# Updating '/venv' to '/workspace/venv' in all text files under '/workspace/venv/bin'
find "/workspace/venv/bin" -type f | while read -r file; do
    if file "$file" | grep -q "text"; then
        sed -i 's|/venv|/workspace/venv|g' "$file"
        #echo "Updated: $file"
    fi
done

echo "**** syncing ComfyUI to workspace, please wait ****"
rsync -au --remove-source-files /ComfyUI/ /workspace/ComfyUI/ && rm -rf /ComfyUI
ln -sf /comfy-checkpoints/* /workspace/ComfyUI/models/checkpoints/
ln -sf /comfy-upscale_models/* /workspace/ComfyUI/models/upscale_models/

#echo "**** Setting the timezone based on the TIME_ZONE environment variable. If not set, it defaults to Etc/UTC. ****" && \
export TZ=${TIME_ZONE:-"Etc/UTC"} && \
echo "**** Timezone set to $TZ ****" && \
echo "$TZ" | sudo tee /etc/timezone > /dev/null && \
sudo ln -sf "/usr/share/zoneinfo/$TZ" /etc/localtime && \
sudo dpkg-reconfigure -f noninteractive tzdata

source /workspace/venv/bin/activate
cd /workspace/ComfyUI

echo "**** Displays the available arguments for running ComfyUI. ****" && python main.py --help

echo "**** Starts ComfyUI, listening on port 3000, with additional arguments specified by COMFYUI_EXTRA_ARGS. ****" && \
python main.py --listen --port 3000 $COMFYUI_EXTRA_ARGS &
