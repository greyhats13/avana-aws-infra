module "s3_bucket" {
  source  = "../../../modules/object-storage"
  region  = var.region
  unit    = var.unit
  env     = var.env
  code    = var.code
  feature = var.feature
  creator = var.creator
}
