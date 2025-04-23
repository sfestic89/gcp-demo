output "iap_client_id" {
  value = google_iap_client.default.client_id
}

output "iap_client_secret" {
  value     = google_iap_client.default.secret
  sensitive = true
}
