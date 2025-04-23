variable "subnets" {
  description = "Map of subnets to create"
  type = map(object({
    project               = string
    vpc                   = string
    region                = string
    cidr_primary          = string
    purpose               = optional(string, "PRIVATE")   # PRIVATE, REGIONAL_MANAGED_PROXY, etc.
    stack_type            = optional(string, "IPV4_ONLY") # IPV4_ONLY, IPV6_ONLY, DUAL_STACK
    private_google_access = optional(bool, false)
    enable_flow_logs      = optional(bool, false)
    hybrid_subnet         = optional(bool, false)

    secondary_ranges = optional(map(object({
      cidr_range = string
    })), null) # Set to `null` when not needed
  }))
}