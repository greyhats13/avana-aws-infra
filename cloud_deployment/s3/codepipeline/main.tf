terraform {
  backend "s3" {
    bucket  = "avn-dev-storage-s3-terraform"
    region  = "ap-southeast-2"
    key     = "avn-storage-s3-pipeline-dev.tfstate"
    profile = "avn-dev"
  }
}

module "s3_bucket" {
  source  = "../../../modules/storage"
  region  = "ap-southeast-2"
  unit    = "avn"
  env     = "dev"
  code    = "storage"
  feature = "s3-pipeline"
}