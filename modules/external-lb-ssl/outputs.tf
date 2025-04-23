output "external_ip_address" {
  value = google_compute_global_address.external_ip.address
}

output "backend_service_name" {
  value = google_compute_backend_service.default.name
}