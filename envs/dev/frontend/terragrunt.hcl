terraform {
  source = "../../../modules/app"
}

inputs = {
  name       = "frontend"
  image      = "nginx:alpine"
  replicas   = 1
  port       = 80
  namespace  = "dev"
  args       = []
  output_dir = "../../../charts/hello-app"

  ingress_from_app = ""

  resources = {
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
