module "cloud_vpn" {
  source = "../modules/cloud-vpn"

  internal_gateways = {
    "gcp-to-onprem-gw" = {
      project    = "prj-g-s-festic-s-7e017f72"
      region     = "europe-west3"
      name       = "gcp-to-onprem-gw"
      network_id = "vpc-dev"
    }
  }

  routers = {
    "gcp-onprem-rt" = {
      project    = "prj-g-s-festic-s-7e017f72"
      region     = "europe-west3"
      name       = "gcp-onprem-rt"
      network_id = "vpc-dev"
      bgp_asn    = 65000
    }
  }

  ext_gw = {
    onprem-gateway = {
      project           = "prj-g-s-festic-s-7e017f72"
      name              = "onprem-vpn"
      redundancy_type   = "SINGLE_IP_INTERNALLY_REDUNDANT"
      description       = "On-prem VPN gateway"
      interface_id      = 0
      interface_ip_addr = "157.90.71.179"
    }
  }

  tunnels = {
    "gcp-to-onprem-tunnel1" = {
      name                            = "gcp-to-onprem-tunnel1"
      project                         = "prj-g-s-festic-s-7e017f72"
      region                          = "europe-west3"
      gateway_key                     = "gcp-to-onprem-gw"
      external_gateway_key            = "onprem-gateway"
      peer_external_gateway_interface = 0
      shared_secret                   = "0ld$ch00L"
      router_key                      = "gcp-onprem-rt"
      vpn_gateway_interface           = 0
    }
  }

  router_interfaces = {
    "rt-iface-1" = {
      name           = "rt-iface-1"
      project        = "prj-g-s-festic-s-7e017f72"
      region         = "europe-west3"
      router_key     = "gcp-onprem-rt"
      vpn_tunnel_key = "gcp-to-onprem-tunnel1"
      ip_range       = "169.254.2.1/30"
    }
  }

  peers = {
    "gcp-onprem-peer1" = {
      name                      = "gcp-onprem-peer1"
      project                   = "prj-g-s-festic-s-7e017f72"
      region                    = "europe-west3"
      router_key                = "gcp-onprem-rt"
      interface_key             = "rt-iface-1"
      peer_ip_address           = "169.254.2.2"
      peer_asn                  = 65502
      advertised_route_priority = 100
    }
  }
}