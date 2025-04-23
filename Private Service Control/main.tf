/**
module "cloud_run" {
  source = "../modules/cloud-run"
  cloud_run_services = {
    "service1" = {
      name                  = "cloud-run-1"
      project               = "prj-g-s-festic-s-7e017f72"
      region                = "europe-west3"
      image                 = "europe-west3-docker.pkg.dev/prj-g-s-festic-s-7e017f72/demo-repo/apache-hello-world:latest"
      port                  = "80"
      env_variables         = { ENV1 = "value1", ENV2 = "value2" }
      cpu                   = "1"
      memory                = "512Mi"
      min_instance_count    = "1"
      ingress               = "INGRESS_TRAFFIC_INTERNAL_ONLY"
      deletion_protecion    = false
      allow_unauthenticated = true
    },
    "service2" = {
      name                  = "cloud-run-2"
      project               = "prj-g-s-festic-s-7e017f72"
      region                = "europe-west3"
      image                 = "europe-west3-docker.pkg.dev/prj-g-s-festic-s-7e017f72/demo-repo/apache-hello-world:latest"
      port                  = "80"
      env_variables         = { ENV1 = "value1", ENV2 = "value2" }
      cpu                   = "1"
      memory                = "512Mi"
      min_instance_count    = "1"
      ingress               = "INGRESS_TRAFFIC_INTERNAL_LOAD_BALANCER"
      deletion_protecion    = false
      allow_unauthenticated = true
    }
  }
}

module "serverless_neg_cloud_run" {
  source            = "../modules/neg"
  name              = "cloud-run-neg"
  region            = "europe-west3"
  cloud_run_service = module.cloud_run.cloud_run_services["service1"]
}


module "internal_lb" {
  source                 = "../modules/internal-lb"
  region                 = "europe-west3"
  project                = "prj-g-s-festic-s-7e017f72"
  url_serverles_neg      = module.serverless_neg_cloud_run.neg_url
  network                = "psc-producer-vpc"
  subnetwork             = "gcp-svc-subnet"
  health_check_name      = "my-health-check"
  health_check_port      = "80"
  backend_service_name   = "cloud-run-1-be"
  forwarding_rule_name   = "my-ilb-forwarding-rule"
  svc_attachment_name    = "psc-cloud-run-test"
  proxy_protocol         = false
  nat_subnets            = ["psc-subnet"]
  consumer_project       = "vmware-migration-vmware-lab"
  consumer_endpoint_name = "cloud-run-enpoint"
  endpoint_network       = "psc-vpc"
}

module "test-vpc" {
  source = "../modules/vpc"
  vpcs = {
    "vpc-dev" = {
      project      = "prj-g-s-festic-s-7e017f72"
      description  = "Development VPC"
      routing_mode = "GLOBAL"
    }
  }
}

module "test-subnet" {
  source = "../modules/subnets"
  subnets = {
    "subnet-no-secondary" = {
      project               = "prj-g-s-festic-s-7e017f72"
      vpc                   = "vpc-dev"
      region                = "europe-west3"
      cidr_primary          = "10.10.0.0/24"
      purpose               = "PRIVATE"
      stack_type            = "IPV4_ONLY"
      private_google_access = false
      enable_flow_logs      = false
      hybrid_subnet         = true

      secondary_ranges = null # No secondary ranges
    }
    "subnet-with-secondary" = {
      project               = "prj-g-s-festic-s-7e017f72"
      vpc                   = "vpc-dev"
      region                = "europe-west3"
      cidr_primary          = "10.1.0.0/24"
      purpose               = "PRIVATE"
      stack_type            = "IPV4_ONLY"
      private_google_access = true
      enable_flow_logs      = true
      hybrid_subnet         = false

      secondary_ranges = {
        "secondary-1" = { cidr_range = "10.2.0.0/24" }
        "secondary-2" = { cidr_range = "10.3.0.0/24" }
      }
    }
  }
}
**/