> If you want to exclude pre-installed models and keep only custom nodes, update the container image to `sombi/comfyui:v0.3.18-torch2.6.0-cu124-no_models` \
> Go to **Edit Template(or Edit Pod) -> Container Image**, make the change, and click **Set Overrides** to save.

| Port | Type (HTTP/TCP) | Function     |
|------|-----------------|--------------|
| 22   | TCP             | SSH          |
| 3000 | HTTP            | ComfyUI      |
| 8888 | HTTP            | JupyterLab  |

| Environment Variable     | Description                                                                 | Default      |
|--------------------------|-----------------------------------------------------------------------------|--------------|
| `JUPYTERLAB_PASSWORD`    | Password for JupyterLab. If unset, no password is required.                 | (Not Set)    |
| `TIME_ZONE`              | System timezone. Defaults to `Etc/UTC` if unset.                            | `Etc/UTC`    |
| `COMFYUI_EXTRA_ARGS`      | Passes additional startup arguments to ComfyUI, allowing extra options like `--fp16-unet` and `--fast`. | (Not Set)    |

#### **Using COMFYUI_EXTRA_ARGS**

- On the "Edit Pod" or "Edit Template" screen, click "Add Environment Variables."
- For the key, enter `COMFYUI_EXTRA_ARGS`, and in the value field, add the desired startup arguments.

#### **Using TIME_ZONE**  

- Find available time zones **<https://en.wikipedia.org/wiki/List_of_tz_database_time_zones>** (e.g., `America/New_York`, `Asia/Seoul`).

| Application | Log file                         |
|-------------|----------------------------------|
| ComfyUI     | /workspace/ComfyUI/user/comfyui_3000.log    |
| JupyterLab  | /workspace/logs/jupyterlab.log      |

If you have any suggestions or issues, please leave feedback at **<https://github.com/somb1/ComfyUI-Docker-RP/issues>**

---

### **Pre-Installed Components**

#### **Base System**

- **OS**: Ubuntu 22.04
- **Framework**: ComfyUI v0.3.15 + ComfyUI Manager + JupyterLab
- **Python**: 3.12
- **Libraries**:
  - PyTorch 2.6.0
  - CUDA 12.4

#### **Models**

##### **Checkpoint Model**

- `ntrMIXIllustriousXL_v40.safetensors` - [Link](https://civitai.com/models/926443?modelVersionId=1061268)

##### **Upscale Models**

- `2x-AnimeSharpV4_RCAN.safetensors` - [Link](https://huggingface.co/Kim2091/2x-AnimeSharpV4)
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
