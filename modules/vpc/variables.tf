variable "vpcs" {
  description = "Map of VPCs to create with their properties"
  type = map(object({
    project      = string
    description  = optional(string, "VPC created via Terraform")
    routing_mode = optional(string, "GLOBAL")
  }))
}
