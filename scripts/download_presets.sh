#!/bin/bash

WGET_OPTS="--show-progress"

if [[ "$1" == "--quiet" ]]; then
    WGET_OPTS="-q"
    shift
fi

# download_if_missing <URL> <TARGET_DIR>
download_if_missing() {
    local url="$1"
    local dest_dir="$2"

    local filename
    filename=$(basename "$url")
    local filepath="$dest_dir/$filename"

    mkdir -p "$dest_dir"

    if [ ! -f "$filepath" ]; then
        echo "Downloading: $filename → $dest_dir"
        wget $WGET_OPTS "$url" -P "$dest_dir"
    else
        echo "File already exists: $filepath (skipping)"
    fi
}

if [ $# -eq 0 ]; then
    echo "Usage: $0 [--quiet] PRESET1,PRESET2,..."
    echo "Example: $0 NTRMIX40,WAN22_T2V_A14B"
    echo "Example (quiet): $0 --quiet NTRMIX40,WAN22_T2V_A14B"
    exit 1
fi

IFS=',' read -ra PRESETS <<< "$1"

echo "**** Checking presets and downloading corresponding files ****"

for preset in "${PRESETS[@]}"; do
    case "${preset}" in
        WAINSFW_V140)
            echo "Preset: WAINSFW_V140"
            download_if_missing "https://huggingface.co/Ine007/waiNSFWIllustrious_v140/resolve/main/waiNSFWIllustrious_v140.safetensors" "/workspace/ComfyUI/models/checkpoints"
            ;;
        NTRMIX_V40)
            echo "Preset: NTRMIX_V40"
            download_if_missing "https://huggingface.co/personal1802/NTRMIXillustrious-XLNoob-XL4.0/resolve/main/ntrMIXIllustriousXL_v40.safetensors" "/workspace/ComfyUI/models/checkpoints"
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
            download_if_missing "https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/I2V/Wan2_2-I2V-A14B-HIGH_fp8_e5m2_scaled_KJ.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/I2V/Wan2_2-I2V-A14B-LOW_fp8_e5m2_scaled_KJ.safetensors" "/workspace/ComfyUI/models/diffusion_models"
            ;;
        WAN22_I2V_A14B_GGUF_Q8_0)
            echo "Preset: WAN22_I2V_A14B_GGUF_Q8_0"
            download_if_missing "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q8_0.gguf" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_high_noise_14B_Q8_0.gguf" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_low_noise_14B_Q8_0.gguf" "/workspace/ComfyUI/models/diffusion_models"
            ;;
        WAN22_I2V_A14B_GGUF_Q6_K)
            echo "Preset: WAN22_I2V_A14B_GGUF_Q6_K"
            download_if_missing "https://huggingface.co/city96/umt5-xxl-encoder-gguf/resolve/main/umt5-xxl-encoder-Q6_K.gguf" "/workspace/ComfyUI/models/text_encoders"
            download_if_missing "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" "/workspace/ComfyUI/models/vae"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_high_noise_14B_Q6_K.gguf" "/workspace/ComfyUI/models/diffusion_models"
            download_if_missing "https://huggingface.co/bullerwins/Wan2.2-I2V-A14B-GGUF/resolve/main/wan2.2_i2v_low_noise_14B_Q6_K.gguf" "/workspace/ComfyUI/models/diffusion_models"
            ;;
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
        WAN22_LIGHTNING_LORA)
            echo "Preset: WAN22_LIGHTNING_LORA"
            #download_if_missing "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan21_CausVid_14B_T2V_lora_rank32.safetensors" "/workspace/ComfyUI/models/loras"
            #download_if_missing "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank32_bf16.safetensors" "/workspace/ComfyUI/models/loras"
            #download_if_missing "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank128_bf16.safetensors" "/workspace/ComfyUI/models/loras"
            download_if_missing "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan22-Lightning/Wan2.2-Lightning_I2V-A14B-4steps-lora_HIGH_fp16.safetensors" "/workspace/ComfyUI/models/loras"
            download_if_missing "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/Wan22-Lightning/Wan2.2-Lightning_I2V-A14B-4steps-lora_LOW_fp16.safetensors" "/workspace/ComfyUI/models/loras"
            ;;
        WAN22_NSFW_LORA)
            echo "Preset: WAN22_NSFW_LORA"
            download_if_missing "https://huggingface.co/3dn3lt/Wan2.2-nsfw-0.08a/resolve/main/NSFW-22-H-e8.safetensors" "/workspace/ComfyUI/models/loras"
            ;;
        UPSCALER_MODELS)
            echo "Preset: UPSCALER_MODELS"
            download_if_missing "https://huggingface.co/Comfy-Org/Real-ESRGAN_repackaged/resolve/main/RealESRGAN_x4plus.safetensors" "/workspace/ComfyUI/models/upscale_models"
            download_if_missing "https://huggingface.co/Kim2091/2x-AnimeSharpV4/resolve/main/2x-AnimeSharpV4_RCAN.safetensors" "/workspace/ComfyUI/models/upscale_models"
            ;;
        *)
            echo "No matching preset for '${preset}', skipping."
            ;;
    esac
done
