resource "google_compute_network_peering" "peering_left" {
  name                 = var.left_peer_name
  network              = var.network
  peer_network         = var.peer_network
  export_custom_routes = var.exchange_network_routes
  import_custom_routes = var.exchange_peer_network_routes
}
resource "google_compute_network_peering" "peering_right" {
  name                 = var.right_peer_name
  network              = var.peer_network
  peer_network         = var.network
  export_custom_routes = var.exchange_peer_network_routes
  import_custom_routes = var.exchange_network_routes
}