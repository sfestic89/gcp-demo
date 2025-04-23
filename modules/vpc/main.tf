resource "google_compute_network" "vpc_network" {
  for_each = var.vpcs

  name                    = each.key
  project                 = each.value.project
  description             = each.value.description
  auto_create_subnetworks = false
  routing_mode            = each.value.routing_mode
}