terraform {
  backend "s3" {
    bucket  = "avn-dev-storage-s3-terraform"
    region  = "ap-southeast-2"
    key     = "avn-security-kms-dev.tfstate"
    profile = "avn-dev"
  }
}

data "local_file" "kms_policy" {
  filename = "${path.module}/kms_policy.json"
}

module "kms" {
  source                   = "../../modules/security/kms"
  region                   = "ap-southeast-2"
  unit                     = "avn"
  env                      = "dev"
  code                     = "security"
  feature                  = ["kms"]
  description              = "General Customer Managed Key on dev account"
  key_usage                = "ENCRYPT_DECRYPT"
  enable_key_rotation      = true
  deletion_window_in_days  = 7
  is_enabled               = true
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
  policy                   = data.local_file.kms_policy.content
}
