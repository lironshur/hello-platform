terraform {
  source = "../../../modules/app"
}

inputs = {
  name      = "backend"
  image     = "hashicorp/http-echo"
  replicas  = 2
  port      = 5678
  namespace = "staging"
  args      = ["-text=hello world", "-listen=:5678"]
  output_dir = "${get_repo_root()}/charts/hello-app"

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
