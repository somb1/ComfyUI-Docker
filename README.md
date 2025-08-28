> 🔄 Updated every 8 hours to always stay on the latest version.

### 🔌 **Exposed Ports**

| Port | Type | Purpose     |
| ---- | ---- | ----------- |
| 22   | TCP  | SSH         |
| 3000 | HTTP | ComfyUI     |
| 8080 | HTTP | code-server |
| 8888 | HTTP | JupyterLab  |

---

### 🏷️ **Tag Structure**

Base format: sombi/comfyui:`(A)`-torch2.8.0-`(B)`

* `(A)`: `base`, `slim`

  * `slim`: ComfyUI + Manager only
  * `base`: `slim` + pre-installed custom nodes
* `(B)`: CUDA version (`12.4`, `12.5`, `12.6`, `12.8`) → (`cu124`, `cu125`, `cu126`, `cu128`)

---

### 🧱 **Image Matrix**

| Image Name                            | Custom Nodes | CUDA |
| ------------------------------------- | ------------ | ---- |
| `sombi/comfyui:base-torch2.8.0-cu124` | ✅            | 12.4 |
| `sombi/comfyui:base-torch2.8.0-cu125` | ✅            | 12.5 |
| `sombi/comfyui:base-torch2.8.0-cu126` | ✅            | 12.6 |
| `sombi/comfyui:base-torch2.8.0-cu128` | ✅            | 12.8 |
| `sombi/comfyui:slim-torch2.8.0-cu124` | ❌            | 12.4 |
| `sombi/comfyui:slim-torch2.8.0-cu125` | ❌            | 12.5 |
| `sombi/comfyui:slim-torch2.8.0-cu126` | ❌            | 12.6 |
| `sombi/comfyui:slim-torch2.8.0-cu128` | ❌            | 12.8 |

To change images: **Edit Pod/Template** → set `Container Image`.

---

### ⚙️ **Environment Variables**

| Variable                | Description                                                                                   | Default   |
| ----------------------- | --------------------------------------------------------------------------------------------- | --------- |
| `ACESS_PASSWORD`        | Password for JupyterLab and code-server                                                       | (unset)   |
| `TIME_ZONE`             | [Timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) (e.g., `Asia/Seoul`) | `Etc/UTC` |
| `COMFYUI_EXTRA_ARGS`    | Extra ComfyUI options (e.g. `--use-sage-attention`)                                           | (unset)   |
| `INSTALL_SAGEATTENTION` | Install [SageAttention2](https://github.com/thu-ml/SageAttention) at start (`True`/`False`)   | `True`    |
| `PRESET_DOWNLOAD`       | Download predefined preset files on startup (e.g. `WAN22_I2V_A14B_GGUF_Q8_0`)                 | (unset)   |

> ⚠️ SageAttention2 requires Ampere or newer GPUs and takes \~5 min to install.

---

### 🔧 Available PRESET_DOWNLOAD Presets

> `PRESET_DOWNLOAD` accepts either a **single preset** or **multiple presets** separated by commas.\
> When set, the container will automatically download the corresponding models on startup.

> You can also manually run the preset download script:
> `/download_presets.sh PRESET1,PRESET2,...`
To set: **Edit Pod/Template** → **Add Environment Variable** (Key/Value).

* `NTRMIX40`
* `WAN22_TI2V_5B`
* `WAN22_T2V_A14B`
* `WAN22_I2V_A14B`
* `WAN22_I2V_A14B_FP8_SCALED`
* `WAN22_I2V_A14B_FP8_E4M3FN_SCALED_KJ`
* `WAN22_I2V_A14B_FP8_E5M2_SCALED_KJ`
* `WAN22_I2V_A14B_GGUF_Q8_0`
* `WAN22_I2V_A14B_GGUF_Q6_K`
* `WAN22_I2V_A14B_GGUF_Q5_K_S`
* `WAN22_I2V_A14B_GGUF_Q5_K_M`
* `WAN22_I2V_A14B_GGUF_Q4_K_S`
* `WAN22_I2V_A14B_GGUF_Q4_K_M`
* `WAN22_LIGHTNING_LORA`
* `WAN22_NSFW_LORA`

> Detailed information and download links are available in the [Wiki](https://github.com/somb1/ComfyUI-Docker/wiki/PRESET_DOWNLOAD).

---

### 📁 **Logs**

| App         | Location                                   |
| ----------- | ------------------------------------------ |
| ComfyUI     | `/workspace/ComfyUI/user/comfyui_3000.log` |
| code-server | `/workspace/logs/code-server.log`          |
| JupyterLab  | `/workspace/logs/jupyterlab.log`           |

---

### 🧩 **Pre-Installed Components**

#### **System**

* **OS**: Ubuntu 24.04 (Ubuntu 22.02 for CUDA 12.4)
* **Python**: 3.13
* **Framework**: [ComfyUI](https://github.com/comfyanonymous/ComfyUI) + [Manager](https://github.com/Comfy-Org/ComfyUI-Manager) + [JupyterLab](https://jupyter.org/) + [code-server]((https://github.com/coder/code-server))
* **Libraries**: PyTorch 2.8.0, CUDA (12.4–12.8), Triton, [hf\_hub](https://huggingface.co/docs/huggingface_hub), [nvtop](https://github.com/Syllo/nvtop)

#### **Custom Nodes**

* [ComfyUI-KJNodes](https://github.com/kijai/ComfyUI-KJNodes)
* [ComfyUI-WanVideoWrapper](https://github.com/kijai/ComfyUI-WanVideoWrapper)
* [ComfyUI-GGUF](https://github.com/city96/ComfyUI-GGUF)
* [ComfyUI-Easy-Use](https://github.com/yolain/ComfyUI-Easy-Use)
* [ComfyUI-Frame-Interpolation](https://github.com/Fannovel16/ComfyUI-Frame-Interpolation)
* [ComfyUI-mxToolkit](https://github.com/Smirnov75/ComfyUI-mxToolkit)
* [ComfyUI-MultiGPU](https://github.com/pollockjj/ComfyUI-MultiGPU)
* [ComfyUI\_TensorRT](https://github.com/comfyanonymous/ComfyUI_TensorRT)
* [ComfyUI\_UltimateSDUpscale](https://github.com/ssitu/ComfyUI_UltimateSDUpscale)
* [comfyui-prompt-reader-node](https://github.com/receyuki/comfyui-prompt-reader-node)
* [ComfyUI\_essentials](https://github.com/cubiq/ComfyUI_essentials)
* [ComfyUI-Impact-Pack](https://github.com/ltdrdata/ComfyUI-Impact-Pack)
* [ComfyUI-Impact-Subpack](https://github.com/ltdrdata/ComfyUI-Impact-Subpack)
* [efficiency-nodes-comfyui](https://github.com/jags111/efficiency-nodes-comfyui)
* [ComfyUI-Custom-Scripts](https://github.com/pythongosssss/ComfyUI-Custom-Scripts)
* [ComfyUI\_JPS-Nodes](https://github.com/JPS-GER/ComfyUI_JPS-Nodes)
* [cg-use-everywhere](https://github.com/chrisgoringe/cg-use-everywhere)
* [ComfyUI-Crystools](https://github.com/crystian/ComfyUI-Crystools)
* [rgthree-comfy](https://github.com/rgthree/rgthree-comfy)
* [ComfyUI-Image-Saver](https://github.com/alexopus/ComfyUI-Image-Saver)

---

💬 Feedback & Issues → [GitHub Issues](https://github.com/somb1/ComfyUI-Docker/issues)

---
