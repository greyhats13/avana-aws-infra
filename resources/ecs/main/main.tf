terraform {
  backend "s3" {
    bucket  = "avn-dev-storage-s3-tfstate-tf"
    region  = "ap-southeast-1"
    key     = "avn-compute-ecs-dev.tfstate"
    profile = "avn-dev"
  }
}

module "vpc" {
  source            = "../../../modules/compute/ecs"
  region            = "ap-southeast-1"
  unit              = "avn"
  env               = "dev"
  code              = "compute"
  feature           = ["ecs"]
  creator           = "tf"
  total_eip         = 2
  domain_name       = "blast.co.id"
  validation_method = "DNS"
}
