output "cloud_run_services" {
  description = "Cloud Run services"
  value = { for k, v in var.cloud_run_services : k => v.name }
}