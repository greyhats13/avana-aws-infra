data "aws_availability_zones" "az" {
}

resource "aws_subnet" "public_subnet" {
  count      = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.public_subnet_cidr, count.index)
  availability_zone = element(data.aws_availability_zones.az.names, count.index)
  tags = {
    "Name" = "${var.unit}-${var.env}-${var.code}-${var.feature[1]}-public-${element(data.aws_availability_zones.az.names, count.index)}-${var.creator}"
    "Env"     = var.env
    "Code"    = var.code
    "Feature" = "${var.feature[1]}-public"
    "Creator" = var.creator
    "Zones"   = element(data.aws_availability_zones.az.names, count.index)
  }
}

resource "aws_subnet" "app_subnet" {
  count      = length(var.app_subnet_cidr)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.app_subnet_cidr, count.index)
  availability_zone = element(data.aws_availability_zones.az.names, count.index)
  tags = {
    "Name" = "${var.unit}-${var.env}-${var.code}-${var.feature[1]}-app-${element(data.aws_availability_zones.az.names, count.index)}-${var.creator}"
    "Env"     = var.env
    "Code"    = var.code
    "Feature" = "${var.feature[1]}-app"
    "Creator" = var.creator
    "Zones"   = element(data.aws_availability_zones.az.names, count.index)
  }
}

resource "aws_subnet" "cache_subnet" {
  count      = length(var.app_subnet_cidr)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.cache_subnet_cidr, count.index)
  availability_zone = element(data.aws_availability_zones.az.names, count.index)
  tags = {
    "Name" = "${var.unit}-${var.env}-${var.code}-${var.feature[1]}-cache-${element(data.aws_availability_zones.az.names, count.index)}-${var.creator}"
    "Env"     = var.env
    "Code"    = var.code
    "Feature" = "${var.feature[1]}-cache"
    "Creator" = var.creator
    "Zones"   = element(data.aws_availability_zones.az.names, count.index)
  }
}

resource "aws_subnet" "db_subnet" {
  count      = length(var.app_subnet_cidr)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.db_subnet_cidr, count.index)
  availability_zone = element(data.aws_availability_zones.az.names, count.index)
  tags = {
    "Name" = "${var.unit}-${var.env}-${var.code}-${var.feature[1]}-db-${element(data.aws_availability_zones.az.names, count.index)}-${var.creator}"
    "Env"     = var.env
    "Code"    = var.code
    "Feature" = "${var.feature[1]}-db"
    "Creator" = var.creator
    "Zones"   = element(data.aws_availability_zones.az.names, count.index)
  }
}