terraform {
  backend "s3" {
    bucket  = "avn-dev-storage-s3-tfstate"
    region  = "us-east-1"
    key     = "avn-network-dev.tfstate"
    profile = "avn-dev"
  }
}

module "vpc" {
  source               = "../../modules/network"
  region               = "us-east-1"
  unit                 = "avn"
  env                  = "dev"
  code                 = "network"
  feature              = ["vpc", "subnet", "igw", "eip", "nat", "route"]
  creator              = "tf"
  vpc_cidr             = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  public_subnet_cidr   = ["10.0.0.0/24", "10.0.1.0/24"]
  app_subnet_cidr      = ["10.0.2.0/24", "10.0.3.0/24"]
  cache_subnet_cidr    = ["10.0.4.0/24", "10.0.5.0/24"]
  db_subnet_cidr       = ["10.0.6.0/24", "10.0.7.0/24"]
  total_eip            = 2
}
