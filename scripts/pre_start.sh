#!/bin/bash

export PYTHONUNBUFFERED=1

echo "**** Setting the timezone based on the TIME_ZONE environment variable. If not set, it defaults to Etc/UTC. ****"
export TZ=${TIME_ZONE:-"Etc/UTC"}
echo "**** Timezone set to $TZ ****"
echo "$TZ" | sudo tee /etc/timezone > /dev/null
sudo ln -sf "/usr/share/zoneinfo/$TZ" /etc/localtime
sudo dpkg-reconfigure -f noninteractive tzdata

echo "**** syncing venv to workspace, please wait. This could take a while on first startup! ****"
if [ -d /venv ]; then
    rsync -au --remove-source-files /venv/ /workspace/venv/ && rm -rf /venv
else
    echo "Skip: /venv does not exist."
fi

# Updating '/venv' to '/workspace/venv' in all text files under '/workspace/venv/bin'
find "/workspace/venv/bin" -type f | while read -r file; do
    if file "$file" | grep -q "text"; then
        # VIRTUAL_ENV='/venv' → VIRTUAL_ENV='/workspace/venv'
        sed -i "s|VIRTUAL_ENV='/venv'|VIRTUAL_ENV='/workspace/venv'|g" "$file"
        
        # VIRTUAL_ENV '/venv' → VIRTUAL_ENV '/workspace/venv'
        sed -i "s|VIRTUAL_ENV '/venv'|VIRTUAL_ENV '/workspace/venv'|g" "$file"
        
        # #!/venv/bin/python → #!/workspace/venv/bin/python
        sed -i "s|#!/venv/bin/python|#!/workspace/venv/bin/python|g" "$file"

        # Uncomment to see which files are updated
        #echo "Updated: $file"
    fi
done

echo "**** syncing ComfyUI to workspace, please wait ****"
if [ -d /ComfyUI ]; then
    rsync -au --remove-source-files /ComfyUI/ /workspace/ComfyUI/ && rm -rf /ComfyUI
else
    echo "Skip: /ComfyUI does not exist."
fi

if [ "${INSTALL_SAGEATTENTION2,,}" = "true" ]; then
    if pip show sageattention > /dev/null 2>&1; then
        echo "**** SageAttention2 is already installed. Skipping installation. ****"
    else
        echo "**** SageAttention2 is not installed. Installing, please wait.... (This may take a long time, approximately 5+ minutes.) ****"
        git clone https://github.com/thu-ml/SageAttention.git /SageAttention
        cd /SageAttention
        python setup.py install
        echo "**** SageAttention2 installation completed. ****"
    fi
fi

download_if_missing() {
    local url="$1"
    local dest_dir="$2"

    local filename=$(basename "$url")
    local filepath="$dest_dir/$filename"

    if [ ! -f "$filepath" ]; then
        echo "Downloading: $filename"
        wget --no-verbose "$url" -P "$dest_dir"
    else
        echo "File already exists: $filepath (skipping)"
    fi
}

echo "**** Checking PRESET_DOWNLOAD and downloading corresponding files ****"
IFS=',' read -ra PRESETS <<< "${PRESET_DOWNLOAD}"
for preset in "${PRESETS[@]}"; do
    case "${preset}" in
        NTRMIX40)
            echo "Preset: NTRMIX40"
            download_if_missing "https://huggingface.co/personal1802/NTRMIXillustrious-XLNoob-XL4.0/resolve/main/ntrMIXIllustriousXL_v40.safetensors" "/workspace/ComfyUI/models/checkpoints"
            download_if_missing "https://huggingface.co/Kim2091/2x-AnimeSharpV4/resolve/main/2x-AnimeSharpV4_RCAN.safetensors" "/workspace/ComfyUI/models/upscale_models"
            ;;

        WAN22_TI2V_5B)
            echo "Preset: WAN22_TI2V_5B"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan2.2_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_ti2v_5B_fp16.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            ;;

        WAN22_T2V_A14B)
            echo "Preset: WAN22_T2V_A14B"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_high_noise_14B_fp8_scaled.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_t2v_low_noise_14B_fp8_scaled.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            ;;

        WAN22_I2V_A14B)
            echo "Preset: WAN22_I2V_A14B"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_high_noise_14B_fp8_scaled.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_low_noise_14B_fp8_scaled.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            ;;

        WAN22_I2V_A14B_FP8_SCALED)
            echo "Preset: WAN22_I2V_A14B_FP8_SCALED"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_high_noise_14B_fp8_scaled.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_low_noise_14B_fp8_scaled.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            ;;

        WAN22_I2V_A14B_FP8_E4M3FN_SCALED_KJ)
            echo "Preset: WAN22_I2V_A14B_FP8_E4M3FN_SCALED_KJ"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/I2V/Wan2_2-I2V-A14B-HIGH_fp8_e4m3fn_scaled_KJ.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/I2V/Wan2_2-I2V-A14B-LOW_fp8_e4m3fn_scaled_KJ.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            ;;
        WAN22_I2V_A14B_FP8_E5M2_SCALED_KJ)
            echo "Preset: WAN22_I2V_A14B_FP8_E5M2_SCALED_KJ"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "hhttps://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/I2V/Wan2_2-I2V-A14B-HIGH_fp8_e5m2_scaled_KJ.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/I2V/Wan2_2-I2V-A14B-LOW_fp8_e5m2_scaled_KJ.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            ;;

        # GGUF Q8
        WAN22_I2V_A14B_GGUF_Q8_0)
            echo "Preset: WAN22_I2V_A14B_GGUF_Q8_0"
            download_if_missing "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q8_0.gguf" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_high_noise_14B_Q8_0.gguf" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_low_noise_14B_Q8_0.gguf" "/workspace/ComfyUI/models/diffusion_models"
            ;;

        # GGUF Q6
        WAN22_I2V_A14B_GGUF_Q6_K)
            echo "Preset: WAN22_I2V_A14B_GGUF_Q6_K"
            download_if_missing "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q6_K.gguf" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_high_noise_14B_Q6_K.gguf" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_low_noise_14B_Q6_K.gguf" "/workspace/ComfyUI/models/diffusion_models"
            ;;

        # GGUF Q5
        WAN22_I2V_A14B_GGUF_Q5_K_S)
            echo "Preset: WAN22_I2V_A14B_GGUF_Q5_K_S"
            download_if_missing "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q5_K_S.gguf" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_high_noise_14B_Q5_K_S.gguf" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_low_noise_14B_Q5_K_S.gguf" "/workspace/ComfyUI/models/diffusion_models"
            ;;
        WAN22_I2V_A14B_GGUF_Q5_K_M)
            echo "Preset: WAN22_I2V_A14B_GGUF_Q5_K_M"
            download_if_missing "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q5_K_M.gguf" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_high_noise_14B_Q5_K_M.gguf" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_low_noise_14B_Q5_K_M.gguf" "/workspace/ComfyUI/models/diffusion_models"
            ;;

        # GGUF Q4
        WAN22_I2V_A14B_GGUF_Q4_K_S)
            echo "Preset: WAN22_I2V_A14B_GGUF_Q4_K_S"
            download_if_missing "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q4_K_S.gguf" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_high_noise_14B_Q4_K_S.gguf" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_low_noise_14B_Q4_K_S.gguf" "/workspace/ComfyUI/models/diffusion_models"
            ;;
        WAN22_I2V_A14B_GGUF_Q4_K_M)
            echo "Preset: WAN22_I2V_A14B_GGUF_Q4_K_M"
            download_if_missing "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q4_K_M.gguf" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_high_noise_14B_Q4_K_M.gguf" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_low_noise_14B_Q4_K_M.gguf" "/workspace/ComfyUI/models/diffusion_models"
            ;;

        # Lightning LoRA
        WAN22_LIGHTNING_LORA)
            echo "Preset: WAN22_LIGHTNING_LORA"
            download_if_missing "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan21_CausVid_14B_T2V_lora_rank32.safetensors" "/workspace/ComfyUI/models/loras"
            download_if_missing "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank32_bf16.safetensors" "/workspace/ComfyUI/models/loras"
            download_if_missing "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank128_bf16.safetensors" "/workspace/ComfyUI/models/loras"
            download_if_missing "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan22-Lightning/Wan2.2-Lightning_I2V-A14B-4steps-lora_HIGH_fp16.safetensors" "/workspace/ComfyUI/models/loras"
            download_if_missing "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan22-Lightning/Wan2.2-Lightning_I2V-A14B-4steps-lora_LOW_fp16.safetensors" "/workspace/ComfyUI/models/loras"
            ;;

        # nsfw LoRA
        WAN22_NSFW_LORA)
            echo "Preset: WAN22_NSFW_LORA"
            download_if_missing "https://huggingface.co/3dn3lt/Wan2.2-nsfw-0.08a/resolve/main/NSFW-22-H-e8.safetensors" "/workspace/ComfyUI/models/loras"
            ;;

        *)
            eecho "No matching preset for '${preset}', skipping."
            ;;
    esac
