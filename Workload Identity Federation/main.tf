module "impersonation" {
  source                 = "../modules/sa-impersionation"
  target_project         = "prj-g-s-festic-s-7e017f72"
  service_account_id     = "github-deployer"
  github_organisation    = "devoteamgcloud"
  github_repository      = "de-retail"
  central_project_number = "684346440845" # central project
  pool_id                = module.wif.pool_id
  github_pool_name       = module.wif.pool_name
}

module "wif" {
  source = "../modules/wif"

  project_id        = "prj-g-s-festic-s-7e017f72"
  pool_id           = "lab-github-pool"
  pool_display_name = "GitHub Workload Identity Pool"
  pool_description  = "Federation pool for GitHub Actions"
  pool_disabled     = false

  provider_id           = "lab-github-provider"
  provider_display_name = "GitHub OIDC Provider"
  provider_description  = "Provider for GitHub OIDC federation"
  provider_disabled     = false

  issuer_uri        = "https://token.actions.githubusercontent.com"
  allowed_audiences = ["https://github.com/devoteamgcloud/de-retail"]
  attribute_mapping = {
    "google.subject"             = "assertion.sub"
    "attribute.repository"       = "assertion.repository"
    "attribute.repository_owner" = "assertion.repository_owner"
  }
  attribute_condition = "attribute.repository == assertion.repository && attribute.repository_owner == assertion.repository_owner"

  #service_account_name = "github-deployer"
  #github_organisation  = "devoteamgcloud"
  #github_repository    = "de-retail"
}
