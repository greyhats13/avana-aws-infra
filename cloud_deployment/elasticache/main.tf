terraform {
  backend "s3" {
    bucket  = "avn-dev-storage-s3-terraform"
    region  = "ap-southeast-2"
    key     = "avn-compute-elasticache-dev.tfstate"
    profile = "avn-dev"
  }
}

module "elasticache" {
  source                     = "../../modules/compute/elasticache"
  region                     = "ap-southeast-2"
  unit                       = "avn"
  env                        = "dev"
  code                       = "compute"
  feature                    = "elasticache"
  engine                     = "redis"
  engine_version             = "6.x"
  maintenance_window         = "sun:14:00-sun:15:00"
  multi_az_enabled           = false
  node_type                  = "cache.t3.medium"
  parameter_group_name       = "default.redis6.x.cluster.on"
  automatic_failover_enabled = true
  port                       = 6379
  snapshot_window            = "21:00-22:00"
  transit_encryption_enabled = true
  at_rest_encryption_enabled = true
}
