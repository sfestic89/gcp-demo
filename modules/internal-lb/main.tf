resource "google_compute_health_check" "default" {
  name = var.health_check_name

  check_interval_sec = var.check_interval_sec
  timeout_sec        = var.timeout_sec

  tcp_health_check {
    port = var.health_check_port
  }
}

resource "google_compute_region_backend_service" "default" {
  name   = var.backend_service_name
  region = var.region
  protocol = "HTTPS"
  load_balancing_scheme = "INTERNAL_MANAGED"
  backend {
    group = var.url_serverles_neg
    balancing_mode = "UTILIZATION"
  }
}
resource "google_compute_region_url_map" "default" {
  #region          = var.region
  name            = "cloud-run-url-map"
  default_service = google_compute_region_backend_service.default.id
}

resource "google_compute_region_target_http_proxy" "default" {
  name    = "cloud-run-http-proxy-test"
  region = var.region
  url_map = google_compute_region_url_map.default.id 
}

# Data block to reference the existing subnetwork
data "google_compute_subnetwork" "proxy_subnet" {
  name    = "proxy-only-subnet-cloud-run"
  region  = "europe-west3"
  project = var.project
}

resource "google_compute_forwarding_rule" "default" {
  name                  = var.forwarding_rule_name
  region                = "europe-west3"
  allow_global_access = true
  load_balancing_scheme = "INTERNAL_MANAGED"
  depends_on            = [data.google_compute_subnetwork.proxy_subnet]
  port_range = "80"
  network               = var.network
  subnetwork            = var.subnetwork
  ip_protocol           = "TCP"
  target               = google_compute_region_target_http_proxy.default.id
  network_tier         = "PREMIUM"
}

resource "google_compute_service_attachment" "default" {
  name        = var.svc_attachment_name
  region      = var.region
  description = "A service attachment configured with Terraform"

  enable_proxy_protocol = var.proxy_protocol
  connection_preference = "ACCEPT_AUTOMATIC"
  nat_subnets           = var.nat_subnets
  target_service        = google_compute_forwarding_rule.default.self_link
  reconcile_connections = true
}

# IP Address
resource "google_compute_address" "consumer_cloud_run_endpoint" {
  name         = "consumer-cloud-run-server-endpoint"
  project = var.consumer_project
  region       = "europe-west3"
  subnetwork   = "psc-subnet"
  address_type = "INTERNAL"
}


resource "google_compute_forwarding_rule" "consumer_endpoint" {
  name                  = var.consumer_endpoint_name
  project = var.consumer_project
  region                = var.region
  network               = var.endpoint_network
  ip_address = google_compute_address.consumer_cloud_run_endpoint.id
  target                = google_compute_service_attachment.default.id
  load_balancing_scheme = "" # Explicit empty required for PSC
}