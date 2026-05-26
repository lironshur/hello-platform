terraform {
  source = "../../../modules/app"
}

inputs = {
  name       = "backend"
  image      = "hashicorp/http-echo"
  replicas   = 2
  port       = 5678
  namespace  = "staging"
  args       = ["-text=hello from backend", "-listen=:5678"]
  output_dir = "../../../charts/hello-app"

  ingress_from_app = "frontend"

  resources = {
    requests = {
      cpu    = "100m"
      memory = "64Mi"
    }
    limits = {
      cpu    = "200m"
      memory = "128Mi"
    }
  }
}
