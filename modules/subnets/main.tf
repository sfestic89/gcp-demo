resource "google_compute_subnetwork" "subnet" {
  for_each = var.subnets

  project                  = each.value.project
  name                     = each.key
  network                  = each.value.vpc
  region                   = each.value.region
  ip_cidr_range            = each.value.cidr_primary
  purpose                  = each.value.purpose
  stack_type               = each.value.stack_type
  private_ip_google_access = each.value.private_google_access

  dynamic "secondary_ip_range" {
    for_each = each.value.secondary_ranges != null ? each.value.secondary_ranges : {}
    content {
      range_name    = secondary_ip_range.key
      ip_cidr_range = secondary_ip_range.value.cidr_range
    }
  }

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = each.value.enable_flow_logs ? 0.5 : 0
    metadata             = "INCLUDE_ALL_METADATA"
  }
}