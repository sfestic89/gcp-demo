resource "google_compute_firewall" "rules" {
  for_each = var.firewall_rules

  name        = try(each.value.name, "${each.key}-firewall-rule")
  project     = var.project
  network     = var.network
  description = try(each.value.description, null)
  direction   = upper(each.value.direction)
  priority    = try(each.value.priority, 1000)
  disabled    = try(each.value.disabled, false)

  // Tags and ranges
  source_ranges             = try(each.value.source_ranges, null)
  destination_ranges        = try(each.value.destination_ranges, null)
  source_tags               = try(each.value.source_tags, null)
  target_tags               = try(each.value.target_tags, null)
  source_service_accounts   = try(each.value.source_service_accounts, null)
  target_service_accounts   = try(each.value.target_service_accounts, null)

  // Action blocks: allow or deny
  dynamic "allow" {
    for_each = each.value.action == "allow" ? each.value.protocols : {}
    content {
      protocol = allow.key
      ports    = try(allow.value, null)
    }
  }

  dynamic "deny" {
    for_each = each.value.action == "deny" ? each.value.protocols : {}
    content {
      protocol = deny.key
      ports    = try(deny.value, null)
    }
  }

  // Optional: enable logging
  dynamic "log_config" {
    for_each = try(each.value.enable_logging, false) ? [1] : []
    content {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }
}