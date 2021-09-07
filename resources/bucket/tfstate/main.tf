module "s3_bucket" {
  source  = "../../../modules/object-storage"
  region  = "ap-southeast-1"
  unit    = "avn"
  env     = "dev"
  code    = "storage"
  feature = "s3-tfstate"
  creator = "tf"
}