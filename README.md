> 🔄 Updated every 8 hours to always stay on the latest version.

### 🔌 **Exposed Ports**

| Port | Type | Purpose    |
| ---- | ---- | ---------- |
| 22   | TCP  | SSH        |
| 3000 | HTTP | ComfyUI    |
| 8888 | HTTP | JupyterLab |

---

### 🏷️ **Tag Structure**

* `ntrmix40`: Includes **NTRMix40** checkpoint + Upscale model
* `wan21`: Includes Wan 2.1 components (Clip Vision, Text Encoder, VAE only — no diffusion model)
* `base`: ComfyUI with custom nodes only, no models.
* `cu124`, `cu126`, `cu128`: CUDA version (12.4 / 12.6 / 12.8)

---

### 🧱 **Image Matrix**

| Image Name                                | Checkpoint   | CUDA |
| ----------------------------------------- | ------------ | ---- |
| `sombi/comfyui:ntrmix40-torch2.7.0-cu124` | ✅ 🎨       | 12.4 |
| `sombi/comfyui:ntrmix40-torch2.7.0-cu126` | ✅ 🎨       | 12.6 |
| `sombi/comfyui:ntrmix40-torch2.7.0-cu128` | ✅ 🎨       | 12.8 |
| `sombi/comfyui:wan21-torch2.7.0-cu124`    | ✅ 🎞️       | 12.4 |
| `sombi/comfyui:wan21-torch2.7.0-cu126`    | ✅ 🎞️       | 12.6 |
| `sombi/comfyui:wan21-torch2.7.0-cu128`    | ✅ 🎞️       | 12.8 |
| `sombi/comfyui:base-torch2.7.0-cu124`     | ❌          | 12.4 |
| `sombi/comfyui:base-torch2.7.0-cu126`     | ❌          | 12.6 |
| `sombi/comfyui:base-torch2.7.0-cu128`     | ❌          | 12.8 |

To change images: Go to **Edit Pod/Template** → Set `Container Image`.

---

### ⚙️ **Environment Variables**

| Variable                 | Description                                                                                   | Default   |
| ------------------------ | --------------------------------------------------------------------------------------------- | --------- |
| `JUPYTERLAB_PASSWORD`    | Password for JupyterLab                                                                       | (unset)   |
| `TIME_ZONE`              | [Timezone](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) (e.g., `Asia/Seoul`) | `Etc/UTC` |
| `COMFYUI_EXTRA_ARGS`     | Extra ComfyUI options (e.g. `--use-sage-attention`)                                           | `--fast`  |
| `INSTALL_SAGEATTENTION2` | Install [SageAttention2](https://github.com/thu-ml/SageAttention) at start (`True`/`False`)   | `False`   |

> ⚠️ SageAttention2 requires Ampere or newer GPUs and takes \~5 min to install.

To set: **Edit Pod/Template** → **Add Environment Variable** (Key/Value)

---

### 📁 **Logs**

| App        | Location                                   |
| ---------- | ------------------------------------------ |
| ComfyUI    | `/workspace/ComfyUI/user/comfyui_3000.log` |
| JupyterLab | `/workspace/logs/jupyterlab.log`           |

---

### 🧩 **Pre-Installed Components**

#### **System**

* **OS**: Ubuntu 22.04
* **Python**: 3.12
* **Framework**: ComfyUI + Manager + JupyterLab
* **Libraries**: PyTorch 2.7.0, CUDA (12.4–12.8), Triton, [hf\_hub](https://huggingface.co/docs/huggingface_hub), [nvtop](https://github.com/Syllo/nvtop)

#### **Models**

* **`ntrmix40` Tagged Images**
  * **Checkpoint**: [ntrMIXIllustriousXL_v40.safetensors](https://civitai.com/models/926443?modelVersionId=1061268)
  * **Upscaler**: [2x-AnimeSharpV4_RCAN.safetensors](https://huggingface.co/Kim2091/2x-AnimeSharpV4)

* **`wan21` Tagged Images**
  * **Clip Vision**: [clip_vision_h.safetensors](https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/blob/main/split_files/clip_vision/clip_vision_h.safetensors)
  * **Text Encoder**: [umt5_xxl_fp8_e4m3fn_scaled.safetensors](https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/blob/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors)
  * **VAE**: [wan_2.1_vae.safetensors](https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/blob/main/split_files/vae/wan_2.1_vae.safetensors)

#### **Custom Nodes**

* [ComfyUI-Custom-Scripts](https://github.com/pythongosssss/ComfyUI-Custom-Scripts)
* [ComfyUI-Crystools](https://github.com/crystian/ComfyUI-Crystools)
* [ComfyUI-essentials](https://github.com/cubiq/ComfyUI_essentials)
* [ComfyUI-Image-Saver](https://github.com/alexopus/ComfyUI-Image-Saver)
* [ComfyUI-Impact-Pack](https://github.com/ltdrdata/ComfyUI-Impact-Pack)
* [ComfyUI-Impact-Subpack](https://github.com/ltdrdata/ComfyUI-Impact-Subpack)
* [ComfyUI_JPS-Nodes](https://github.com/JPS-GER/ComfyUI_JPS-Nodes)
* [ComfyUI_TensorRT](https://github.com/comfyanonymous/ComfyUI_TensorRT)
* [ComfyUI_UltimateSDUpscale](https://github.com/ssitu/ComfyUI_UltimateSDUpscale)
* [comfyui-prompt-reader-node](https://github.com/receyuki/comfyui-prompt-reader-node)
* [cg-use-everywhere](https://github.com/chrisgoringe/cg-use-everywhere)
* [efficiency-nodes-comfyui](https://github.com/jags111/efficiency-nodes-comfyui)
* [rgthree-comfy](https://github.com/rgthree/rgthree-comfy)
* [ComfyUI-WanVideoWrapper](https://github.com/kijai/ComfyUI-WanVideoWrapper)
* [ComfyUI-VideoHelperSuite](https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite)
* [ComfyUI-GGUF](https://github.com/city96/ComfyUI-GGUF)
* [ComfyUI-KJNodes](https://github.com/kijai/ComfyUI-KJNodes)
* [ComfyUI-WanStartEndFramesNative](https://github.com/Flow-two/ComfyUI-WanStartEndFramesNative)
* [ComfyUI-mxToolkit](https://github.com/Smirnov75/ComfyUI-mxToolkit)
* [ComfyUI-Frame-Interpolation](https://github.com/Fannovel16/ComfyUI-Frame-Interpolation)

---

💬 Feedback & Issues → [GitHub Issues](https://github.com/somb1/ComfyUI-Docker-RP/issues)

---
