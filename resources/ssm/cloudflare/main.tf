terraform {
  backend "s3" {
    bucket  = "avn-dev-storage-s3-tfstate-tf"
    region  = "ap-southeast-1"
    key     = "avn-ssm-cloudflare-dev.tfstate"
    profile = "avn-dev"
  }
}

variable "cloudflare" {
  #secret value in tfvars, tfvars is in .gitignore
}

module "ssm" {
  source     = "../../../modules/parameter_store"
  region            = "ap-southeast-1"
  unit              = "avn"
  env               = "dev"
  code              = "ssm"
  feature           = "cloudflare"
  creator           = "tf"
  overwrite         = true
  cloudflare        = var.cloudflare
}
