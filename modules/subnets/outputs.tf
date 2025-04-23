output "subnets" {
  description = "Details of the created subnets"
  value = {
    for k, v in google_compute_subnetwork.subnet : k => {
      name             = v.name
      project          = v.project
      region           = v.region
      network          = v.network
      ip_cidr_range    = v.ip_cidr_range
      secondary_ranges = v.secondary_ip_range
    }
  }
}