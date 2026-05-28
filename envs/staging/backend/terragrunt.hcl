include "env" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/app"
}

inputs = {
  name             = "backend"
  image            = "hashicorp/http-echo"
  replicas         = 2
  port             = 5678
  node_port        = 30084
  args             = ["-text=hello world", "-listen=:5678"]
  ingress_from_app = "frontend"
  resources = {
    requests = { cpu = "100m", memory = "64Mi" }
    limits   = { cpu = "200m", memory = "128Mi" }
  }
}
