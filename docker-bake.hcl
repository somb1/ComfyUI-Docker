variable "DOCKERHUB_REPO_NAME" {
    default = "sombi/comfyui"
}

variable "PYTHON_VERSION" {
    default = "3.12"
}
variable "TORCH_VERSION" {
    default = "2.7.0"
}

variable "EXTRA_TAG" {
    default = ""
}

function "tag" {
    params = [tag, cuda]
    result = ["${DOCKERHUB_REPO_NAME}:${tag}-torch${TORCH_VERSION}-${cuda}${EXTRA_TAG}"]
}

target "_common" {
    dockerfile = "Dockerfile"
    context = "."
    args = {
        PYTHON_VERSION     = PYTHON_VERSION
        TORCH_VERSION      = TORCH_VERSION
    }
}

target "_cu124" {
    inherits = ["_common"]
    args = {
        BASE_IMAGE         = "nvidia/cuda:12.4.1-devel-ubuntu22.04"
        CUDA_VERSION       = "cu124"
    }
}

target "_cu126" {
    inherits = ["_common"]
    args = {
        BASE_IMAGE         = "nvidia/cuda:12.6.3-devel-ubuntu22.04"
        CUDA_VERSION       = "cu126"
    }
}

target "_cu128" {
    inherits = ["_common"]
    args = {
        BASE_IMAGE         = "nvidia/cuda:12.8.1-devel-ubuntu22.04"
        CUDA_VERSION       = "cu128"
    }
}

target "_ntrmix40" {
    args = {
        PREINSTALLED_MODEL = "NTRMIX40"
    }
}

target "_wan21" {
    args = {
        PREINSTALLED_MODEL = "WAN21"
    }
}

target "base-12-4" {
    inherits = ["_cu124"]
    tags = tag("base", "cu124")
}

target "base-12-6" {
    inherits = ["_cu126"]
    tags = tag("base", "cu126")
}

target "base-12-8" {
    inherits = ["_cu128"]
    tags = tag("base", "cu128")
}

target "ntrmix40-12-4" {
    inherits = ["_cu124", "_ntrmix40"]
    tags = tag("ntrmix40", "cu124")
}

target "ntrmix40-12-6" {
    inherits = ["_cu126", "_ntrmix40"]
    tags = tag("ntrmix40", "cu126")
}

target "ntrmix40-12-8" {
    inherits = ["_cu128", "_ntrmix40"]
    tags = tag("ntrmix40", "cu128")
}

target "wan21-12-4" {
    inherits = ["_cu124", "_wan21"]
    tags = tag("wan21", "cu124")
}

target "wan21-12-6" {
    inherits = ["_cu126", "_wan21"]
    tags = tag("wan21", "cu126")
}

target "wan21-12-8" {
    inherits = ["_cu128", "_wan21"]
    tags = tag("wan21", "cu128")
}
