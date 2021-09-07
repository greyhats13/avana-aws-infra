terraform {
  backend "s3" {
    bucket  = "avn-dev-storage-s3-tfstate-tf"
    region  = "ap-southeast-1"
    key     = "avn-ssm-github-dev.tfstate"
    profile = "avn-dev"
  }
}

variable "list_of_ssm" {
  #secret value in tfvars, tfvars is in .gitignore
}

module "ssm" {
  source      = "../../../modules/parameter_store"
  region      = "ap-southeast-1"
  unit        = "avn"
  env         = "dev"
  code        = "ssm"
  feature     = "github"
  creator     = "tf"
  overwrite   = true
  list_of_ssm = var.list_of_ssm
}
