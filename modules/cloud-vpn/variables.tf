variable "internal_gateways" {
  description = "Map of HA VPN Gateways."
  type = map(object({
    project    = string
    region     = string
    name       = string
    network_id = string
  }))
}

variable "routers" {
  description = "Map of Cloud Routers."
  type = map(object({
    project    = string
    region     = string
    name       = string
    network_id = string
    bgp_asn    = number
  }))
}

variable "tunnels" {
  description = "Map of VPN tunnels."
  type = map(object({
    name                            = string
    project                         = string
    region                          = string
    gateway_key                     = string
    external_gateway_key            = string
    peer_external_gateway_interface = number
    shared_secret                   = string
    router_key                      = string
    vpn_gateway_interface           = number
  }))
}

variable "router_interfaces" {
  description = "Map of router interfaces."
  type = map(object({
    name           = string
    project        = string
    region         = string
    router_key     = string
    vpn_tunnel_key = string
    ip_range       = string
  }))
}

variable "peers" {
  description = "Map of router BGP peers."
  type = map(object({
    name                      = string
    project                   = string
    region                    = string
    router_key                = string
    interface_key             = string
    peer_ip_address           = string
    peer_asn                  = number
    advertised_route_priority = number
  }))
}

variable "ext_gw" {
  description = "Map of external VPN gateways to create. Typically represents on-prem VPN routers."
  type = map(object({
    project           = string
    name              = string
    redundancy_type   = string
    description       = string
    interface_id      = number
    interface_ip_addr = string
  }))
}