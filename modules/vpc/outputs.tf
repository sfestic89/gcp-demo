output "vpc_name" {
  value = tomap({
    for k, name in google_compute_network.vpc_network : k => name.id
  })
}