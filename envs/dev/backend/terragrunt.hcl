include "env" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/app"
}

inputs = {
  name             = "backend"
  image            = "hashicorp/http-echo"
  replicas         = 1
  port             = 5678
  node_port        = 30082
  args             = ["-text=hello world", "-listen=:5678"]
  ingress_from_app = "frontend"
  resources = {
    requests = { cpu = "50m", memory = "32Mi" }
    limits   = { cpu = "100m", memory = "64Mi" }
  }
}
