terraform {
  backend "s3" {
    bucket  = "avn-dev-storage-s3-tfstate"
    region  = "us-east-1"
    key     = "avn-storage-s3-codepipeline-dev.tfstate"
    profile = "avn-dev"
  }
}

module "s3_bucket" {
  source  = "../../../modules/storage"
  region  = "us-east-1"
  unit    = "avn"
  env     = "dev"
  code    = "storage"
  feature = "s3-codepipeline"
}