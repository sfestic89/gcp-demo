/**
# IAP Client ID and Secret fetched from Google Secret Manager
data "google_secret_manager_secret_version" "iap_client_id" {
  secret  = "iap-cloud-run-svc2"
  project = "684346440845"
}

data "google_secret_manager_secret_version" "iap_client_secret" {
  secret  = "iap-cloud-run-svc2"
  project = "684346440845"
}
**/
# CREATE A PUBLIC IP ADDRESS
resource "google_compute_global_address" "external_ip" {
  project      = var.project
  name         = "https-external-ip-cloud-run"
  ip_version   = "IPV4"
  address_type = "EXTERNAL"
}

# CREATE A MANAGED SSL CERTIFICATE
resource "google_compute_managed_ssl_certificate" "default" {
  name    = "ssl-cert"
  project = var.project

  managed {
    domains = [var.domain_name] # e.g., "myapp.example.com"
  }
}

resource "google_compute_backend_service" "default" {
  name       = var.backend_service_name
  project    = var.project
  protocol   = "HTTPS" # Use HTTPS protocol for IAP
  enable_cdn = false
  backend {
    group           = var.url_serverles_neg
    capacity_scaler = 1.0
  }
  iap {
    enabled = true
    #oauth2_client_id     = data.google_secret_manager_secret_version.iap_client_id.secret_data
    #oauth2_client_secret = data.google_secret_manager_secret_version.iap_client_secret.secret_data
  }
}


# CREATE URL MAP FOR CLOUD RUN BACKEND
resource "google_compute_url_map" "default" {
  project         = var.project
  name            = "external-cloud-run-url-map"
  default_service = google_compute_backend_service.default.id
}

# CREATE HTTPS PROXY
resource "google_compute_target_https_proxy" "default" {
  name             = "external-cloud-run-https-proxy"
  project          = var.project
  url_map          = google_compute_url_map.default.id
  ssl_certificates = [google_compute_managed_ssl_certificate.default.id]
}

# FORWARDING RULE FOR HTTPS (PORT 443)
resource "google_compute_global_forwarding_rule" "default" {
  provider   = google-beta
  name       = "default-fw-rule-name-https"
  project    = var.project
  target     = google_compute_target_https_proxy.default.id
  ip_address = google_compute_global_address.external_ip.address
  port_range = "443"

  depends_on = [
    google_compute_global_address.external_ip,
    google_compute_managed_ssl_certificate.default
  ]
}

resource "google_iap_web_backend_service_iam_binding" "iap_access_binding" {
  project             = var.project
  web_backend_service = google_compute_backend_service.default.name
  role                = "roles/iap.httpsResourceAccessor"

  members = var.members
}