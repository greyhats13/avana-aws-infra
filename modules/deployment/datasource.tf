data "aws_caller_identity" "account" {}

data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket  = "${var.unit}-${var.env}-storage-s3-tfstate"
    key     = "${var.unit}-network-${var.env}.tfstate"
    region  = var.region
    profile = "${var.unit}-${var.env}"
  }
}

data "terraform_remote_state" "ecs" {
  backend = "s3"
  config = {
    bucket  = "${var.unit}-${var.env}-storage-s3-tfstate"
    key     = "${var.unit}-compute-ecs-${var.env}.tfstate"
    region  = var.region
    profile = "${var.unit}-${var.env}"
  }
}

data "terraform_remote_state" "kms" {
  backend = "s3"
  config = {
    bucket  = "${var.unit}-${var.env}-storage-s3-tfstate"
    key     = "${var.unit}-security-kms-${var.env}.tfstate"
    region  = var.region
    profile = "${var.unit}-${var.env}"
  }
}

data "terraform_remote_state" "s3" {
  backend = "s3"
  config = {
    bucket  = "${var.unit}-${var.env}-storage-s3-tfstate"
    key     = "${var.unit}-storage-s3-codepipeline-${var.env}.tfstate"
    region  = var.region
    profile = "${var.unit}-${var.env}"
  }
}

data "template_file" "container_definitions" {
  template = file("${path.module}/container_definitions.json")
  vars = {
    unit               = var.unit
    env                = var.env
    code               = var.code
    feature            = var.feature
    image              = aws_ecr_repository.ecr_php.repository_url
    cpu                = var.cpu
    memory             = var.memory
    memory_reservation = var.memory_reservation
    port               = var.container_port
  }
}

data "template_file" "ecr_lifecycle_policy" {
  template = file("${path.module}/ecr_lifecycle_policy.json")
}