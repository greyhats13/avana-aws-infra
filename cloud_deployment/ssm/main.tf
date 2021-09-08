terraform {
  backend "s3" {
    bucket  = "avn-dev-storage-s3-terraform"
    region  = "ap-southeast-2"
    key     = "avn-security-ssm-dev.tfstate"
    profile = "avn-dev"
  }
}

variable "list_of_ssm" {
  #secret value in tfvars, tfvars is in .gitignore
}

module "ssm" {
  source      = "../../modules/security/ssm"
  region      = "ap-southeast-2"
  unit        = "avn"
  env         = "dev"
  code        = "security"
  feature     = "ssm"
  creator     = "tf"
  overwrite   = true
  list_of_ssm = var.list_of_ssm
}
