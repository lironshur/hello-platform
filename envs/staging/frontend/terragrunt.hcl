include "env" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../../modules/app"
}

inputs = {
  name             = "frontend"
  image            = "nginx:alpine"
  replicas         = 2
  port             = 80
  node_port        = 30083
  args             = []
  ingress_from_app = ""
  resources = {
    requests = { cpu = "100m", memory = "128Mi" }
    limits   = { cpu = "200m", memory = "256Mi" }
  }
}
