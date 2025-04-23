data "google_compute_network" "main" {
  name    = var.vpc_network
  project = var.project_id

}

// We define a VPC peering subnet that will be peered with the
// Managed Service provided by Google.
// https://cloud.google.com/vpc/docs/configure-private-services-access
resource "google_compute_global_address" "google-managed-services-range" {
  provider      = google-beta
  project       = var.project_id
  name          = "google-managed-services-${var.vpc_network}"
  purpose       = "VPC_PEERING"
  address       = var.address
  prefix_length = var.prefix_length
  ip_version    = var.ip_version
  labels        = var.labels
  address_type  = "INTERNAL"
  network       = data.google_compute_network.main.self_link
}

# Creates the peering with the producer network.
resource "google_service_networking_connection" "private_service_access" {
  provider                = google-beta
  network                 = data.google_compute_network.main.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.google-managed-services-range.name]
}

resource "null_resource" "dependency_setter" {
  depends_on = [google_service_networking_connection.private_service_access]
}

# configure import/export custom routes
resource "google_compute_network_peering_routes_config" "peering_primary_routes" {
  depends_on = [google_service_networking_connection.private_service_access]
  network    = var.vpc_network
  peering    = "servicenetworking-googleapis-com"

  import_custom_routes = true
  export_custom_routes = true
}