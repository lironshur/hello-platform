output "helm_values_path" {
  value       = local_file.helm_values.filename
  description = "Absolute path to the generated Helm values file"
}

output "app_name" {
  value       = var.name
  description = "Application name passed to the Helm chart"
}

output "namespace" {
  value       = var.namespace
  description = "Target Kubernetes namespace"
}
