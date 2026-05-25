terraform {
  source = "../../../modules/app"
}

inputs = {
  name       = "hello-app"
  image      = "nginx:alpine"
  replicas   = 1
  port       = 80
  namespace  = "dev"
  output_dir = "../../../charts/hello-app"

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
