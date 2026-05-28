output "helm_values_path" {
  value = local_file.helm_values.filename
}

output "app_name" {
  value = var.name
}

output "namespace" {
  value = var.namespace
}
