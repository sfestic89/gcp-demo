
# Create IAP Brand
resource "google_iap_brand" "default" {
  project           = var.project_id
  support_email     = var.support_email
  application_title = var.application_title
}

# Create an IAP Client for the OAuth configuration
resource "google_iap_client" "default" {
  brand        = google_iap_brand.default.name
  display_name = var.client_display_name
}

# Enable IAP on Cloud Run's Backend Service
resource "google_iap_web_backend_service_iam_binding" "iap_binding" {
  project             = var.project_id
  web_backend_service = var.backend_service_name
  role                = "roles/iap.httpsResourceAccessor"
  members             = var.members
}
