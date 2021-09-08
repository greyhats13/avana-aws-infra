terraform {
  backend "s3" {
    bucket  = "avn-dev-storage-s3-terraform"
    region  = "ap-southeast-2"
    key     = "avn-compute-ec2-bastion-dev.tfstate"
    profile = "avn-dev"
  }
}

module "ec2" {
  source                      = "../../modules/compute/ec2"
  region                      = "ap-southeast-2"
  unit                        = "avn"
  env                         = "dev"
  code                        = "compute"
  feature                     = "ec2"
  instance_type               = "t3.small"
  ami                         = "ami-0210560cedcb09f07"
  associate_public_ip_address = true
  volume_type                 = "gp3"
  volume_size                 = 20
}
