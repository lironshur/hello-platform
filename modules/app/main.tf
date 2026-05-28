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
  # split "nginx:alpine" into repo and tag so helm gets them separately
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
      # if a nodePort was given, use NodePort — otherwise default to ClusterIP
      type     = var.node_port != null ? "NodePort" : "ClusterIP"
      port     = var.port
      nodePort = var.node_port
    }
    nameOverride = var.name
    args         = var.args
    resources    = var.resources
    networkPolicy = {
      enabled        = true
      ingressFromApp = var.ingress_from_app
    }
  }
}

# writes the values file that ArgoCD will use when deploying this service
resource "local_file" "helm_values" {
  content  = yamlencode(local.values)
  filename = "${var.output_dir}/values-${var.namespace}-${var.name}.yaml"
}
