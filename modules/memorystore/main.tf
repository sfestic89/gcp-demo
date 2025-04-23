resource "google_redis_instance" "redis" {
  provider           = google-beta
  project            = var.project_id
  name               = var.name
  tier               = var.tier
  memory_size_gb     = var.memory_size_gb
  connect_mode       = var.connect_mode
  region             = var.region
  authorized_network = var.authorized_network
  redis_version      = var.redis_version
  redis_configs      = var.redis_configs
  auth_enabled       = var.auth_enabled
  display_name       = var.display_name
  reserved_ip_range  = var.reserved_ip_range

  lifecycle {
    ignore_changes = []
  }
}