terraform {
  source = "../../../modules/app"
}

inputs = {
  name       = "hello-app"
  image      = "nginx:alpine"
  replicas   = 2
  port       = 80
  namespace  = "staging"
  output_dir = "../../../charts/hello-app"

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
