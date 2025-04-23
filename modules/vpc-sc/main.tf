resource "google_access_context_manager_access_policy" "access_policy" {
  parent = "organizations/${var.organization_id}"
  title  = var.policy_title
}
/**
resource "google_access_context_manager_service_perimeter" "vpc_sc_perimeter" {
  name        = "${var.access_policy}/servicePerimeters/${var.perimeter_name}"
  parent      = var.access_policy
  title       = var.perimeter_name
  description = var.description

  perimeter_type = "PERIMETER_TYPE_REGULAR"

  status {
    resources = var.project_numbers

    restricted_services = var.restricted_services

    access_levels = var.access_levels

    vpc_accessible_services {
      allowed_services   = var.allowed_vpc_services
      enable_restriction = var.enable_vpc_restriction
    }
  }
}
**/