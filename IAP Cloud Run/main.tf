module "prod_cloudrun_neg" {
  source            = "../modules/neg"
  name              = "prod-cloud-run-neg"
  region            = "europe-west3"
  cloud_run_service = module.cloud_run.cloud_run_services["service2"]
  cloud_function    = null # Set to null or provide the function name if using Cloud Functions
}

module "https_external_lb" {
  source = "../modules/external-lb-ssl"

  project              = "prj-g-s-festic-s-7e017f72"
  domain_name          = "api.de-gcloud.com" # This should match your DNS name
  backend_service_name = "https-cloud-run-backend"
  url_serverles_neg    = module.prod_cloudrun_neg.neg_url
  members              = ["user:semir@dev.devoteam.de", "user:semir.festic@devoteam.com"] # Example of member
}

module "public_dns" {
  source  = "../modules/cloud-dns/dns-records"
  project = "prj-g-s-festic-s-7e017f72"

  managed_zone = "de-gcloud" # must match the name in GCP exactly

  records = {
    "api.de-gcloud.com." = {
      type    = "A"
      ttl     = 300
      rrdatas = [module.https_external_lb.external_ip_address]
    }
  }
}