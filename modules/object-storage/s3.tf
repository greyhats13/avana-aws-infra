provider "aws" {
  region  = var.region
  profile = "${var.unit}-${var.env}"
}

resource "aws_s3_bucket" "tfstate" {
  bucket = "${var.unit}-${var.env}-${var.code}-${var.feature}-${var.creator}"
  acl    = "private"

  tags = {
    Name    = "${var.unit}-${var.env}-${var.code}-${var.feature}"
    Env     = var.env
    Creator = var.creator
  }
}
