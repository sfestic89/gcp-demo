output "external_ip_address" {
  value = google_compute_global_address.external_ip.address
}

# Output the authorized redirect URI for IAP
output "authorized-redirect-uri" {
  value = "https://iap.googleapis.com/v1/oauth/clientIds/${var.OAUTH_CLIENT_ID}:handleRedirect"
}