terraform {
  required_version = ">= 1.3.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

locals {
  image_parts = split(":", var.image)
  image_repo  = local.image_parts[0]
  image_tag   = length(local.image_parts) > 1 ? local.image_parts[1] : "latest"

  values = {
    replicaCount = var.replicas
    image = {
      repository = local.image_repo
      tag        = local.image_tag
      pullPolicy = "IfNotPresent"
    }
    service = {
      type = "ClusterIP"
      port = var.port
    }
    nameOverride = var.name
    resources    = var.resources
    networkPolicy = {
      enabled = true
    }
  }
}

resource "local_file" "helm_values" {
  content  = yamlencode(local.values)
  filename = "${var.output_dir}/values-${var.namespace}.yaml"
}
