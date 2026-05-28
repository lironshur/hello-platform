include "env" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/app"
}

inputs = {
  name             = "frontend"
  image            = "nginx:alpine"
  replicas         = 1
  port             = 80
  node_port        = 30081
  args             = []
  ingress_from_app = ""
  resources = {
    requests = { cpu = "50m", memory = "64Mi" }
    limits   = { cpu = "100m", memory = "128Mi" }
  }
}
