variable "cloud_run_services" {
  description = "List of Cloud Run services"
  type = map(object({
    name                  = string
    project               = string
    region                = string
    image                 = string
    port                  = string
    env_variables         = map(string)
    cpu                   = string
    memory                = string
    deletion_protecion    = bool
    ingress               = string
    min_instance_count    = string
    allow_unauthenticated = string
  }))
}