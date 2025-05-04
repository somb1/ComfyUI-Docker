> 🔄 Updated every 8 hours to always stay on the latest version.

### 🔌 Exposed Ports

| Port | Type | Purpose    |
| ---- | ---- | ---------- |
| 22   | TCP  | SSH        |
| 3000 | HTTP | ComfyUI    |
| 8888 | HTTP | JupyterLab |

---

### 🏷️ Tag Structure

* `ntrmix40`: Includes **NTRMix40** checkpoint + Upscale model
* `base`: ComfyUI with custom nodes only, no models.
* `cu124`, `cu126`, `cu128`: CUDA version (12.4 / 12.6 / 12.8)

---

### 🧱 Image Matrix

| Image Name                  | Checkpoint | CUDA |
| --------------------------- | ---------- | ---- |
| `sombi/comfyui:ntrmix40-torch2.7.0-cu124` | ✅          | 12.4 |
| `sombi/comfyui:ntrmix40-torch2.7.0-cu126` | ✅          | 12.6 |
| `sombi/comfyui:ntrmix40-torch2.7.0-cu128` | ✅          | 12.8 |
| `sombi/comfyui:base-torch2.7.0-cu124`     | ❌          | 12.4 |
| `sombi/comfyui:base-torch2.7.0-cu126`     | ❌          | 12.6 |
| `sombi/comfyui:base-torch2.7.0-cu128`     | ❌          | 12.8 |

To change images: Go to **Edit Pod/Template** → Set `Container Image`.

---

### ⚙️ Environment Variables

| Variable                 | Description                                                                                 | Default   |
| ------------------------ | ------------------------------------------------------------------------------------------- | --------- |
| `JUPYTERLAB_PASSWORD`    | Password for JupyterLab (optional)                                                          | (unset)   |
| `TIME_ZONE`              | Timezone (e.g., `Asia/Seoul`)                                                               | `Etc/UTC` |
| `COMFYUI_EXTRA_ARGS`     | Extra ComfyUI options (e.g., `--fast`)                                                      | (unset)   |
| `INSTALL_SAGEATTENTION2` | Install [SageAttention2](https://github.com/thu-ml/SageAttention) at start (`True`/`False`) | `False`   |

> ⚠️ SageAttention2 requires Ampere or newer GPUs and takes \~5 min to install.

To set: **Edit Pod/Template** → **Add Environment Variable** (Key/Value)

---

### 📁 Logs

| App        | Location                                   |
| ---------- | ------------------------------------------ |
| ComfyUI    | `/workspace/ComfyUI/user/comfyui_3000.log` |
| JupyterLab | `/workspace/logs/jupyterlab.log`           |

---

### 🧩 Pre-Installed Components

#### System

* **OS**: Ubuntu 22.04
* **Python**: 3.12
* **Framework**: ComfyUI + Manager + JupyterLab
* **Libraries**: PyTorch 2.7.0, CUDA (12.4–12.8), Triton, [hf\_hub](https://huggingface.co/docs/huggingface_hub), [nvtop](https://github.com/Syllo/nvtop)

#### Models

* **Checkpoint**: [ntrMIXIllustriousXL_v40.safetensors](https://civitai.com/models/926443?modelVersionId=1061268)
* **Upscaler**: [2x-AnimeSharpV4_RCAN.safetensors](https://huggingface.co/Kim2091/2x-AnimeSharpV4)

#### Custom Nodes

* [ComfyUI-Custom-Scripts](https://github.com/pythongosssss/ComfyUI-Custom-Scripts)
* [ComfyUI-Crystools](https://github.com/crystian/ComfyUI-Crystools)
* [ComfyUI-essentials](https://github.com/cubiq/ComfyUI_essentials)
* [ComfyUI-Image-Saver](https://github.com/alexopus/ComfyUI-Image-Saver)
* [ComfyUI-Impact-Pack](https://github.com/ltdrdata/ComfyUI-Impact-Pack)
* [ComfyUI-Impact-Subpack](https://github.com/ltdrdata/ComfyUI-Impact-Subpack)
* [ComfyUI\_JPS-Nodes](https://github.com/JPS-GER/ComfyUI_JPS-Nodes)
* [ComfyUI\_TensorRT](https://github.com/comfyanonymous/ComfyUI_TensorRT)
* [ComfyUI\_UltimateSDUpscale](https://github.com/ssitu/ComfyUI_UltimateSDUpscale)
* [comfyui-prompt-reader-node](https://github.com/receyuki/comfyui-prompt-reader-node)
* [cg-use-everywhere](https://github.com/chrisgoringe/cg-use-everywhere)
* [efficiency-nodes-comfyui](https://github.com/jags111/efficiency-nodes-comfyui)
* [rgthree-comfy](https://github.com/rgthree/rgthree-comfy)

---

💬 Feedback & Issues → [GitHub Issues](https://github.com/somb1/ComfyUI-Docker-RP/issues)

---
