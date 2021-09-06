terraform {
  backend "s3" {
    bucket  = "avn-dev-storage-s3-tfstate-tf"
    region  = "ap-southeast-1"
    key     = "avn-network-dev.tfstate"
    profile = "avn-dev"
  }
}

#Naming standard
variable "region" {
  default = "ap-southeast-1"
}

variable "unit" {
  default = "avn"
}

variable "env" {
  default = "dev"
}

variable "code" {
  default = "network"
}

variable "feature" {
  default = ["vpc", "subnet", "igw", "eip", "nat", "route"]
}

variable "creator" {
  default = "tf"
}

#VPC Arguments
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "enable_dns_support" {
  default = true
}

variable "enable_dns_hostnames" {
  default = true
}

#Subnet Arguments
variable "public_subnet_cidr" {
  default = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "app_subnet_cidr" {
  default = ["10.0.2.0/24", "10.0.3.0/24"]
}

variable "cache_subnet_cidr" {
  default = ["10.0.4.0/24", "10.0.5.0/24"]
}

variable "db_subnet_cidr" {
  default = ["10.0.6.0/24", "10.0.7.0/24"]
}

#Elastic IP arguments
variable "total_eip" {
  default = 2
}
