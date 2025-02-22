# Set the base image
ARG BASE_IMAGE
FROM ${BASE_IMAGE}

# Set the shell and enable pipefail for better error handling
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Set basic environment variables
ARG COMFYUI_VERSION
ARG PYTHON_VERSION
ARG TORCH_VERSION
ARG CUDA_VERSION

# Set basic environment variables
ENV SHELL=/bin/bash 
ENV PYTHONUNBUFFERED=True 
ENV DEBIAN_FRONTEND=noninteractive
ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/x86_64-linux-gnu 
ENV UV_COMPILE_BYTECODE=1
ENV TZ=Etc/UTC

# Override the default huggingface cache directory.
ENV HF_HOME="/runpod-volume/.cache/huggingface/"
ENV HF_DATASETS_CACHE="/runpod-volume/.cache/huggingface/datasets/"
ENV DEFAULT_HF_METRICS_CACHE="/runpod-volume/.cache/huggingface/metrics/"
ENV DEFAULT_HF_MODULES_CACHE="/runpod-volume/.cache/huggingface/modules/"
ENV HUGGINGFACE_HUB_CACHE="/runpod-volume/.cache/huggingface/hub/"
ENV HUGGINGFACE_ASSETS_CACHE="/runpod-volume/.cache/huggingface/assets/"

# Faster transfer of models from the hub to the container
ENV HF_HUB_ENABLE_HF_TRANSFER="1"

# Shared python package cache
ENV PIP_CACHE_DIR="/runpod-volume/.cache/pip/"
ENV UV_CACHE_DIR="/runpod-volume/.cache/uv/"

# Set working directory
WORKDIR /

# Install essential packages (optimized to run in one command)
RUN apt-get update --yes && \
    apt-get upgrade --yes && \
    apt-get install --yes --no-install-recommends \
        git wget curl bash nginx-light rsync sudo binutils ffmpeg lshw nano tzdata file build-essential \
        libgl1 libglib2.0-0 \
        openssh-server ca-certificates && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Install the UV tool from astral-sh
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh
ENV PATH="/root/.local/bin/:$PATH"

# Install Python and create virtual environment
RUN uv python install ${PYTHON_VERSION} --default --preview && \
    uv venv --seed /venv
ENV PATH="/workspace/venv/bin:/venv/bin:$PATH"

# Install essential Python packages and dependencies
RUN pip install --no-cache-dir -U \
    pip setuptools wheel \
    jupyterlab jupyterlab_widgets ipykernel ipywidgets \
    huggingface_hub hf_transfer \
    torch==${TORCH_VERSION} torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/${CUDA_VERSION}

# Install ComfyUI and ComfyUI Manager
RUN git clone https://github.com/comfyanonymous/ComfyUI.git && \
    cd ComfyUI && \
    git checkout tags/${COMFYUI_VERSION} && \
    pip install --no-cache-dir -r requirements.txt && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git custom_nodes/ComfyUI-Manager && \
    cd custom_nodes/ComfyUI-Manager && \
    pip install --no-cache-dir -r requirements.txt

# 1. Clone custom nodes repositories
RUN cd ComfyUI/custom_nodes && \
    git clone --recursive https://github.com/ssitu/ComfyUI_UltimateSDUpscale.git && \
    git clone --recursive https://github.com/receyuki/comfyui-prompt-reader-node.git && \
    git clone https://github.com/comfyanonymous/ComfyUI_TensorRT.git && \
    git clone https://github.com/cubiq/ComfyUI_essentials.git && \
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git && \
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Subpack.git && \
    git clone https://github.com/jags111/efficiency-nodes-comfyui.git && \
    git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git && \
    git clone https://github.com/JPS-GER/ComfyUI_JPS-Nodes.git && \
    git clone https://github.com/chrisgoringe/cg-use-everywhere.git && \
    git clone https://github.com/crystian/ComfyUI-Crystools.git && \
    git clone https://github.com/rgthree/rgthree-comfy.git && \
    git clone https://github.com/alexopus/ComfyUI-Image-Saver.git

# Find and install requirements.txt files, and execute install.py scripts in custom nodes,  
# limiting the search to 2 levels  
RUN find ComfyUI/custom_nodes -maxdepth 2 -name "requirements.txt" -exec pip install --no-cache-dir -r {} \; && \
    find ComfyUI/custom_nodes -maxdepth 2 -name "install.py" -exec python {} \;

# Ensure some directories are created in advance
RUN mkdir -p /comfy-checkpoints /comfy-upscale_models /workspace/{ComfyUI,logs,venv}

# Download models
RUN huggingface-cli download --quiet personal1802/NTRMIXillustrious-XLNoob-XL4.0 ntrMIXIllustriousXL_v40.safetensors --local-dir /comfy-checkpoints && \
    huggingface-cli download --quiet Kim2091/AnimeSharpV3  2x-AnimeSharpV3.pth --local-dir /comfy-upscale_models && \
    huggingface-cli download --quiet Kim2091/AnimeSharp 4x-AnimeSharp.pth --local-dir /comfy-upscale_models && \
    huggingface-cli download --quiet Kim2091/2x-AnimeSharpV4 2x-AnimeSharpV4_RCAN.safetensors --local-dir /comfy-upscale_models && \
    huggingface-cli delete-cache

#RUN wget -q https://huggingface.co/personal1802/NTRMIXillustrious-XLNoob-XL4.0/resolve/main/ntrMIXIllustriousXL_v40.safetensors -P /comfy-checkpoints
#RUN wget -q https://huggingface.co/Kim2091/AnimeSharpV3/resolve/main/2x-AnimeSharpV3.pth -P /comfy-upscale_models
#RUN wget -q https://huggingface.co/Kim2091/AnimeSharp/resolve/main/4x-AnimeSharp.pth -P /comfy-upscale_models
#RUN wget -q https://huggingface.co/Kim2091/2x-AnimeSharpV4/resolve/main/2x-AnimeSharpV4_RCAN.safetensors -P /comfy-upscale_models

# NGINX Proxy Configuration
COPY proxy/nginx.conf /etc/nginx/nginx.conf
COPY proxy/readme.html /usr/share/nginx/html/readme.html
COPY README.md /usr/share/nginx/html/README.md

# Copy and set execution permissions for start scripts
COPY scripts/start.sh /
COPY scripts/pre_start.sh /
RUN chmod +x /start.sh /pre_start.sh

# Welcome Message displayed upon login
COPY logo/runpod.txt /etc/runpod.txt
RUN echo 'cat /etc/runpod.txt' >> /root/.bashrc
RUN echo 'echo -e "\nFor detailed documentation and guides, please visit:\n\033[1;34mhttps://docs.runpod.io/\033[0m and \033[1;34mhttps://blog.runpod.io/\033[0m\n\n"' >> /root/.bashrc

# Set entrypoint to the start script
CMD ["/start.sh"]
