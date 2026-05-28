terraform {
  source = "../../../modules/app"
}

inputs = {
  name      = "backend"
  image     = "hashicorp/http-echo"
  replicas  = 1
  port      = 5678
  node_port = 30082
  namespace = "dev"
  args      = ["-text=hello world", "-listen=:5678"]
  output_dir = "../../../charts/hello-app"

  # only the frontend is allowed to reach the backend
  ingress_from_app = "frontend"

  resources = {
    requests = {
      cpu    = "50m"
      memory = "32Mi"
    }
    limits = {
      cpu    = "100m"
      memory = "64Mi"
    }
  }
}
