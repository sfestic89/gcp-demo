resource "google_compute_ha_vpn_gateway" "ha_gateway" {
  for_each = var.internal_gateways

  project  = each.value.project
  region   = each.value.region
  name     = each.value.name
  network  = each.value.network_id
}

resource "google_compute_router" "routers" {
  for_each = var.routers

  name     = each.value.name
  project  = each.value.project
  region   = each.value.region
  network  = each.value.network_id

  bgp {
    asn = each.value.bgp_asn
  }
}

resource "google_compute_vpn_tunnel" "tunnel" {
  for_each = var.tunnels

  name        = each.value.name
  region      = each.value.region
  project     = each.value.project

  vpn_gateway           = google_compute_ha_vpn_gateway.ha_gateway[each.value.gateway_key].id
  peer_external_gateway = google_compute_external_vpn_gateway.external_gateway[each.value.external_gateway_key].id
  peer_external_gateway_interface = each.value.peer_external_gateway_interface
  shared_secret                   = each.value.shared_secret
  router                          = google_compute_router.routers[each.value.router_key].id
  vpn_gateway_interface           = each.value.vpn_gateway_interface
}

resource "google_compute_router_interface" "routers_interfaces" {
  for_each = var.router_interfaces

  name       = each.value.name
  project    = each.value.project
  region     = each.value.region
  router     = google_compute_router.routers[each.value.router_key].name
  vpn_tunnel = google_compute_vpn_tunnel.tunnel[each.value.vpn_tunnel_key].name
  ip_range   = each.value.ip_range
}

resource "google_compute_router_peer" "peers" {
  for_each = var.peers

  name                      = each.value.name
  project                   = each.value.project
  region                    = each.value.region
  router                    = google_compute_router.routers[each.value.router_key].name
  peer_ip_address           = each.value.peer_ip_address
  peer_asn                  = each.value.peer_asn
  advertised_route_priority = each.value.advertised_route_priority
  interface                 = google_compute_router_interface.routers_interfaces[each.value.interface_key].name
}

resource "google_compute_external_vpn_gateway" "external_gateway" {
  for_each        = var.ext_gw
  project         = each.value.project
  name            = each.value.name
  redundancy_type = each.value.redundancy_type
  description     = each.value.description
  interface {
    id         = each.value.interface_id
    ip_address = each.value.interface_ip_addr
  }
}