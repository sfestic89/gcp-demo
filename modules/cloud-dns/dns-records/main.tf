resource "google_dns_record_set" "records" {
  for_each     = var.records
  project      = var.project
  managed_zone = var.managed_zone
  name         = each.key
  type         = each.value.type
  ttl          = each.value.ttl
  rrdatas      = each.value.rrdatas
}