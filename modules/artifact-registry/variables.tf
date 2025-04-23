variable "project_id" {
  description = "The GCP project where the Artifact Registry repositories will be created"
  type        = string
}

variable "repositories" {
  description = "List of Artifact Registry repositories to create"
  type = list(object({
    repo_id  = string                    # ID of the repository
    location = string                    # Location (e.g., us-central1)
    format   = string                    # Format (e.g., DOCKER, MAVEN, NPM)
    labels   = optional(map(string), {}) # Optional labels
  }))
}