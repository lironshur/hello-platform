# root config — inherited by all envs
# get_repo_root() gives an absolute path so it works from any subdirectory
locals {
  repo_root = get_repo_root()
}

inputs = {
  output_dir = "${local.repo_root}/charts/hello-app"
}
