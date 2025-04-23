variable "project" {
  description = "The GCP project ID"
  type        = string
}

variable "managed_zone" {
  description = "The name of the existing Cloud DNS managed zone"
  type        = string
}

variable "records" {
  description = <<EOT
A map of DNS records to create.
Example:
  {
    "api.example.com." = {
      type    = "A"
      ttl     = 300
      rrdatas = ["34.8.238.109"]
    }
  }
EOT
  type = map(object({
    type    = string
    ttl     = number
    rrdatas = list(string)
  }))
}