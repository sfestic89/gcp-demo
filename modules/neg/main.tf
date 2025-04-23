resource "google_compute_region_network_endpoint_group" "serverless_neg" {
  name                  = var.name
  network_endpoint_type = "SERVERLESS"
  region                = var.region
  dynamic "cloud_run" {
    for_each = var.cloud_run_service != null ? [1] : []
    content {
      service = var.cloud_run_service
    }
  }

  dynamic "cloud_function" {
    for_each = var.cloud_function != null ? [1] : []
    content {
      function = var.cloud_function
    }
  }

}
