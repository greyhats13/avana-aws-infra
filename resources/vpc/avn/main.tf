module "vpc" {
  source                           = "../../../modules/network"
  region                           = var.region
  unit                             = var.unit
  env                              = var.env
  code                             = var.code
  feature                          = var.feature
  creator                          = var.creator
  vpc_cidr                         = var.vpc_cidr
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_hostnames
  public_subnet_cidr               = var.public_subnet_cidr
  app_subnet_cidr                  = var.app_subnet_cidr
  cache_subnet_cidr                = var.cache_subnet_cidr
  db_subnet_cidr                   = var.db_subnet_cidr
  total_eip                        = 2 
}
