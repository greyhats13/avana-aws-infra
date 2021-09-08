provider "aws" {
  region  = var.region
  profile = "${var.unit}-${var.env}"
}

data "aws_availability_zones" "az" {}

data "terraform_remote_state" "kms" {
  backend = "s3"
  config = {
    bucket  = "${var.unit}-${var.env}-storage-s3-terraform"
    key     = "${var.unit}-security-kms-${var.env}.tfstate"
    region  = var.region
    profile = "${var.unit}-${var.env}"
  }
}

resource "random_password" "aurora_password" {
  length           = 16
  upper            = true
  lower            = true
  number           = true
  special          = false
  override_special = "_~!#$&*="
  min_lower        = 2
  min_upper        = 2
  min_special      = 0
  min_numeric      = 2
}

resource "aws_rds_cluster" "aurora" {
  cluster_identifier                  = "${var.unit}-${var.env}-${var.code}-${var.feature}-cluster"
  engine_mode                         = var.engine_mode
  engine                              = var.engine
  engine_version                      = var.engine_version
  availability_zones                  = [data.aws_availability_zones.az.names[0], data.aws_availability_zones.az.names[1]]
  master_username                     = var.master_username
  master_password                     = random_password.aurora_password.result
  port                                = var.port
  db_subnet_group_name                = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids              = [aws_security_group.sg.id]
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  db_cluster_parameter_group_name     = aws_rds_cluster_parameter_group.cluster_parameter_group.id
  backup_retention_period             = var.backup_retention_period
  copy_tags_to_snapshot               = var.copy_tags_to_snapshot
  storage_encrypted                   = var.storage_encrypted
  kms_key_id                          = var.storage_encrypted ? data.terraform_remote_state.kms.outputs.kms_key_arn : null
  backtrack_window                    = var.backtrack_window
  allow_major_version_upgrade         = var.allow_major_version_upgrade
  enabled_cloudwatch_logs_exports     = var.enabled_cloudwatch_logs_exports
  preferred_backup_window             = var.preferred_backup_window
  deletion_protection                 = var.deletion_protection
  apply_immediately                   = var.apply_immediately
  skip_final_snapshot                 = var.skip_final_snapshot
  tags = {
    "Name"    = "${var.unit}-${var.env}-${var.code}-${var.feature}-cluster"
    "Env"     = var.env
    "Code"    = var.code
    "Feature" = var.feature
  }
  lifecycle {
    prevent_destroy = false
    ignore_changes = [
      engine_version
    ]
  }
}
