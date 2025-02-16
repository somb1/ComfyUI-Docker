| Port | Type (HTTP/TCP) | Function     |
|------|-----------------|--------------|
| 22   | TCP             | SSH          |
| 3000 | HTTP            | ComfyUI      |
| 8888 | HTTP            | JupyterLab  |

| Environment Variable     | Description                                                                 | Default      |
|--------------------------|-----------------------------------------------------------------------------|--------------|
| `COMFYUI_EXTRA_ARGS`      | Passes additional arguments to ComfyUI at startup, allowing configuration of extra options like `--highvram`, `--fp16-unet`, and `--fast`. | (Not Set)    |
| `JUPYTERLAB_PASSWORD`    | Set a password for JupyterLab. If not set, no password is required.         | (Not Set - No Password) |
| `TIME_ZONE`           | Sets the system timezone. If not set, defaults to `Etc/UTC`.                | `Etc/UTC`    |

- **How to use COMFYUI_EXTRA_ARGS?**: On the Edit Pod or Edit Template screen, click 'Add Environment Variables,' enter `COMFYUI_EXTRA_ARGS` for the key, and add the desired startup arguments in the value.

- **How to use TIME_ZONE?**: Available time zones can be found at <https://en.wikipedia.org/wiki/List_of_tz_database_time_zones> (e.g., `America/New_York`, `Asia/Seoul`).

| Application | Log file                         |
|-------------|----------------------------------|
| ComfyUI     | /workspace/ComfyUI/user/comfyui_3000.log    |
| JupyterLab  | /workspace/logs/jupyterlab.log      |

---

### **Pre-Installed Components**

#### **Base System**

- **OS**: Ubuntu 22.04
- **Framework**: ComfyUI 0.3.14 + ComfyUI Manager + JupyterLab
- **Python**: 3.12
- **Libraries**:
  - PyTorch 2.5.1
  - CUDA 12.1

#### **Models**

- **Checkpoint Model**: `ntrMIXIllustriousXL_v40.safetensors` - [Link](https://civitai.com/models/926443?modelVersionId=1061268)  
- **Upscale Models**:  
  - `2x-AnimeSharpV3.pth`  - [Link](https://huggingface.co/Kim2091/AnimeSharpV3)  
  - `4x-AnimeSharp.pth`  - [Link](https://huggingface.co/Kim2091/AnimeSharp)  

#### **Custom Nodes**  

- `ComfyUI-Custom-Scripts` - [Link](https://github.com/pythongosssss/ComfyUI-Custom-Scripts)  
- `ComfyUI-Crystools` - [Link](https://github.com/crystian/ComfyUI-Crystools)  
- `ComfyUI-essentials` - [Link](https://github.com/cubiq/ComfyUI_essentials)  
- `ComfyUI-Image-Saver` - [Link](https://github.com/alexopus/ComfyUI-Image-Saver)  
- `ComfyUI-Impact-Pack` - [Link](https://github.com/ltdrdata/ComfyUI-Impact-Pack)  
- `ComfyUI-Impact-Subpack` - [Link](https://github.com/ltdrdata/ComfyUI-Impact-Subpack)  
- `ComfyUI_JPS-Nodes` - [Link](https://github.com/JPS-GER/ComfyUI_JPS-Nodes)  
- `ComfyUI_TensorRT` - [Link](https://github.com/comfyanonymous/ComfyUI_TensorRT)  
- `ComfyUI_UltimateSDUpscale` - [Link](https://github.com/ssitu/ComfyUI_UltimateSDUpscale)  
- `comfyui-prompt-reader-node` - [Link](https://github.com/receyuki/comfyui-prompt-reader-node)  
- `cg-use-everywhere` - [Link](https://github.com/chrisgoringe/cg-use-everywhere)  
- `efficiency-nodes-comfyui` - [Link](https://github.com/jags111/efficiency-nodes-comfyui)  
- `rgthree-comfy` - [Link](https://github.com/rgthree/rgthree-comfy)
