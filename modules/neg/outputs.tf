output "name" {
  description = "The name of the created Network Endpoint Group"
  value       = google_compute_region_network_endpoint_group.serverless_neg
}

output "neg_url" {
  value = google_compute_region_network_endpoint_group.serverless_neg.id
}