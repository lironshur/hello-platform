variable "name" {
  type = string
}

variable "image" {
  type    = string
  default = "nginx:alpine"
}

variable "replicas" {
  type    = number
  default = 1
}

variable "port" {
  type    = number
  default = 80
}

variable "namespace" {
  type        = string
  description = "used as part of the generated values filename"
  default     = "dev"
}

variable "args" {
  type        = list(string)
  description = "optional container args (e.g. for http-echo)"
  default     = []
}

variable "ingress_from_app" {
  type        = string
  description = "restrict ingress to pods with this app name (leave empty to allow all)"
  default     = ""
}

variable "resources" {
  type = object({
    requests = object({
      cpu    = string
      memory = string
    })
    limits = object({
      cpu    = string
      memory = string
    })
  })
  default = {
    requests = {
      cpu    = "50m"
      memory = "64Mi"
    }
    limits = {
      cpu    = "100m"
      memory = "128Mi"
    }
  }
}

variable "output_dir" {
  type    = string
  default = "../../../charts/hello-app"
}
