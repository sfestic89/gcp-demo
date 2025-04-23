module "data_exfiltration_prevention" {
  source          = "../modules/vpc-sc"
  organization_id = "2971695485"
  policy_title    = "test-policy"
  /**
  access_policy          = "default"
  perimeter_name         = "sensitive-data-perimeter"
  description            = "Test Perimeter"
  project_numbers        = ["684346440845"]
  restricted_services    = ["bigquery.googleapis.com", "storage.googleapis.com"]
  access_levels          = ["accessPolicies/1234567890/accessLevels/onlyCorp"]
  allowed_vpc_services   = ["all_services"]
  enable_vpc_restriction = false
**/
}