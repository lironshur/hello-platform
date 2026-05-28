terraform {
  source = "../../../modules/app"
}

inputs = {
  name      = "frontend"
  image     = "nginx:alpine"
  replicas  = 2
  port      = 80
  node_port = 30083
  namespace = "staging"
  args      = []
  output_dir = "${get_repo_root()}/charts/hello-app"

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
