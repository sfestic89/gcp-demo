variable "project" {
  type        = string
  description = "GCP project ID"
}

variable "network" {
  type        = string
  description = "VPC network name"
}

variable "firewall_rules" {
  type = map(object({
    name                      = optional(string)
    description               = optional(string)
    direction                 = string                # INGRESS or EGRESS
    action                    = string                # allow or deny
    priority                  = optional(number)
    disabled                  = optional(bool)
    enable_logging            = optional(bool)
    source_ranges             = optional(list(string))
    destination_ranges        = optional(list(string))
    source_tags               = optional(list(string))
    target_tags               = optional(list(string))
    source_service_accounts   = optional(list(string))
    target_service_accounts   = optional(list(string))
    protocols                 = map(list(string))     # ex: { tcp = ["22", "80"] }
  }))
  description = "Map of firewall rules"
}