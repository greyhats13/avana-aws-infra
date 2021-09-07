terraform {
  backend "s3" {
    bucket  = "avn-dev-storage-s3-tfstate-tf"
    region  = "ap-southeast-1"
    key     = "avn-compute-ecs-dev.tfstate"
    profile = "avn-dev"
  }
}

module "vpc" {
  source                           = "../../../modules/compute/ecs"
  region                           = "ap-southeast-1"
  unit                             = "avn"
  env                              = "dev"
  code                             = "compute"
  feature                          = ["ecs"]
  creator                          = "tf"
  total_eip                        = 2
  nlb_port                         = 80
  nlb_protocol                     = "TCP"
  target_type                      = "ip"
  deregistration_delay             = "30"
  health_check_interval            = "30"
  healthy_threshold                = 5
  unhealthy_threshold              = 5
  enable_cross_zone_load_balancing = true
  domain_name                      = "blast.co.id"
  validation_method                = "DNS"
}
