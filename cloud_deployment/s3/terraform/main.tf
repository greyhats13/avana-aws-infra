module "s3_bucket" {
  source  = "../../../modules/storage"
  region  = "ap-southeast-2"
  unit    = "avn"
  env     = "dev"
  code    = "storage"
  feature = "s3-terraform"
}