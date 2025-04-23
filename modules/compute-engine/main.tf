resource "random_string" "random-identifier" {
  length  = 4
  special = false
  upper   = false
  lower   = true
}
resource "google_compute_instance" "ce-template" {
  name         = format("%s-%s", var.ce_name, random_string.random-identifier.result)
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = var.boot_image
    }
  }

  network_interface {
    network            = var.network
    subnetwork         = var.subnetwork
    subnetwork_project = var.project_id

    dynamic "access_config" {
      for_each = var.public_ip ? [1] : []
      content {}
    }
  }
  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  metadata_startup_script = var.startup_script
}
