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
  description = "used as the suffix for the generated values filename"
  default     = "dev"
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
