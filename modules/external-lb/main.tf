# Assuming var.OAUTH_CLIENT_ID is defined and available
variable "OAUTH_CLIENT_ID" {
  description = "The OAuth client ID for IAP authentication"
  type        = string
}

# IAP Client ID and Secret fetched from Google Secret Manager
data "google_secret_manager_secret_version" "iap_client_id" {
  secret  = "iap-cloud-run-svc2"
  project = "684346440845"
}

data "google_secret_manager_secret_version" "iap_client_secret" {
  secret  = "iap-cloud-run-svc2"
  project = "684346440845"
}

# Create a managed SSL certificate for HTTPS
resource "google_compute_managed_ssl_certificate" "default" {
  project = var.project
  name    = "ssl-cert"
  managed {
    domains = [
      "api.de-gcloud.com",  # Replace with your domain
    ]
  }
}

# Create a public IP address
resource "google_compute_global_address" "external_ip" {
  project      = var.project
  name         = "external-ip-cloud-run"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

# Backend service pointing to Cloud Run
resource "google_compute_backend_service" "default" {
  name       = var.backend_service_name
  project    = var.project
  protocol   = "HTTPS"  # Use HTTPS protocol for IAP
  enable_cdn = false
  backend {
    group           = var.url_serverles_neg
    capacity_scaler = 1.0
  }
  iap {
    enabled              = true
    oauth2_client_id     = data.google_secret_manager_secret_version.iap_client_id.secret_data
    oauth2_client_secret = data.google_secret_manager_secret_version.iap_client_secret.secret_data
  }
}

# Create URL map for Cloud Run backend
resource "google_compute_url_map" "default" {
  project         = var.project
  name            = "external-cloud-run-url-map"
  default_service = google_compute_backend_service.default.id
}

# Target HTTPS proxy
resource "google_compute_target_https_proxy" "default" {
  name             = "external-cloud-run-https-proxy"
  project          = var.project
  url_map          = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]  # Attach SSL certificate here
}

# Forwarding rule for HTTPS
resource "google_compute_global_forwarding_rule" "default" {
  provider   = google-beta
  target     = google_compute_target_https_proxy.default.id
  project    = var.project
  name       = "default-fw-rule-name"
  ip_address = google_compute_global_address.external_ip.address
  port_range = "443"  # Use port 443 for HTTPS

  depends_on = [google_compute_global_address.external_ip]
}

# IAP IAM member for backend service access
resource "google_iap_web_backend_service_iam_member" "iap_access" {
  project             = var.project
  web_backend_service = google_compute_backend_service.default.name
  role                = "roles/iap.httpsResourceAccessor"
  member              = "user:semir@dev.devoteam.de"
}

# IAM policy binding for IAP
resource "google_iam_policy" "iap_iam_policy" {
  binding {
    role    = "roles/iap.httpsResourceAccessor"
    members = [
      "user:semir@dev.devoteam.de",  # Replace with actual user or service account
    ]
  }
}

# Output the authorized redirect URI for IAP
output "authorized-redirect-uri" {
  value = "https://iap.googleapis.com/v1/oauth/clientIds/${var.OAUTH_CLIENT_ID}:handleRedirect"
}
