terraform {
  source = "../../../modules/app"
}

inputs = {
  name       = "frontend"
  image      = "nginx:alpine"
  replicas   = 2
  port       = 80
  namespace  = "staging"
  args       = []
  output_dir = "../../../charts/hello-app"

  ingress_from_app = ""

  resources = {
    requests = {
      cpu    = "100m"
      memory = "128Mi"
    }
    limits = {
      cpu    = "200m"
      memory = "256Mi"
    }
  }
}
