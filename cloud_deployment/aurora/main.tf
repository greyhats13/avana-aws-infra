terraform {
  backend "s3" {
    bucket  = "avn-dev-storage-s3-terraform"
    region  = "ap-southeast-2"
    key     = "avn-compute-rds-aurora-dev.tfstate"
    profile = "avn-dev"
  }
}

module "rds" {
  source                              = "../../modules/compute/rds"
  region                              = "ap-southeast-2"
  unit                                = "avn"
  env                                 = "dev"
  code                                = "compute"
  feature                             = "rds-aurora"
  parameter_group_family              = "aurora-mysql5.7"
  engine_mode                         = "provisioned"
  engine                              = "aurora-mysql"
  engine_version                      = "5.7.mysql_aurora.2.10.0"
  master_username                     = "root"
  port                                = 3306
  backup_retention_period             = 5
  preferred_backup_window             = "07:00-09:00"
  iam_database_authentication_enabled = false
  copy_tags_to_snapshot               = true
  storage_encrypted                   = true
  backtrack_window                    = 0
  allow_major_version_upgrade         = true
  enabled_cloudwatch_logs_exports     = ["error", "general", "slowquery"]
  deletion_protection                 = false
  apply_immediately                   = true
  skip_final_snapshot                 = true
}
