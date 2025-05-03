### Exposed Ports

| Port | Type (HTTP/TCP) | Function     |
|------|-----------------|--------------|
| 22   | TCP             | SSH          |
| 3000 | HTTP            | ComfyUI      |
| 8888 | HTTP            | JupyterLab  |

---

### Container Image

| Image Name | Description                      |
| ---------- | -------------------------------- |
| `base`     | Custom nodes only.               |
| `ntrmix40` | Custom nodes + `ntrMIXIllustriousXL_v40` model. |
| `ilxl20`   | Custom nodes + `Illustrious-XL-v2.0` model.   |

#### How to Set Container Image

To use a specific container image, go to **Edit Template** or **Edit Pod**, set the desired **Container Image**, and apply the changes.

---

### Environment Variables

| Variable                   | Description                                                                    | Default        |
|----------------------------|--------------------------------------------------------------------------------|----------------|
| `JUPYTERLAB_PASSWORD`      | Password for JupyterLab. If unset, no password will be required.               | (Not Set)      |
| `TIME_ZONE`                | System timezone. Defaults to `Etc/UTC` if unset.                               | `Etc/UTC`      |
| `COMFYUI_EXTRA_ARGS`       | Extra startup options for ComfyUI, e.g., `--fast`.                             | (Not Set)      |
| `INSTALL_SAGEATTENTION2`    | Install SageAttention2 at startup (`True` or `False`). May take over 5 minutes. | `False`         |

> **Note**: SageAttention2 installs successfully only on GPUs with the Ampere architecture or later.

#### How to Set Environment Variables

1. On the **Edit Pod** or **Edit Template** screen, click **"Add Environment Variable."**
2. For **Key**, enter the name of the variable (e.g., `COMFYUI_EXTRA_ARGS`).
3. For **Value**, enter the desired setting or option.

> For time zones, refer to [this list of time zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) (e.g., `America/New_York`).

---

### Log Files

| Application | Log file                         |
|-------------|----------------------------------|
| ComfyUI     | /workspace/ComfyUI/user/comfyui_3000.log    |
| JupyterLab  | /workspace/logs/jupyterlab.log      |

> If you encounter any issues or have suggestions, feel free to leave feedback at **[GitHub Issues](https://github.com/somb1/ComfyUI-Docker-RP/issues)**.

---

### **Pre-Installed Components**

#### **Base System**

- **OS**: Ubuntu 22.04
- **Framework**: ComfyUI + ComfyUI Manager + JupyterLab
- **Python**: 3.12
- **Libraries**:
  - PyTorch 2.6.0
  - CUDA 12.4
  - [huggingface_hub](https://huggingface.co/docs/huggingface_hub/index), [hf_transfer](https://huggingface.co/docs/huggingface_hub/index)
  - [nvtop](https://github.com/Syllo/nvtop)

#### **Models**

##### **Checkpoint Model**

- `ntrMIXIllustriousXL_v40.safetensors` - [Link](https://civitai.com/models/926443?modelVersionId=1061268)

##### **Upscale Models**

- `2x-AnimeSharpV4_RCAN.safetensors` - [Link](https://huggingface.co/Kim2091/2x-AnimeSharpV4)

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
