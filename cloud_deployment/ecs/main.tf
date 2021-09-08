terraform {
  backend "s3" {
    bucket  = "avn-dev-storage-s3-terraform"
    region  = "ap-southeast-2"
    key     = "avn-compute-ecs-dev.tfstate"
    profile = "avn-dev"
  }
}

module "ecs" {
  source                           = "../../modules/compute/ecs"
  region                           = "ap-southeast-2"
  unit                             = "avn"
  env                              = "dev"
  code                             = "compute"
  feature                          = ["ecs"]
  total_eip                        = 2
  enable_cross_zone_load_balancing = true
  domain_name                      = "blast.co.id"
  validation_method                = "DNS"
}
