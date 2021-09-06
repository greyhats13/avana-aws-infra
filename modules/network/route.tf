#Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name"    = "${var.unit}-${var.env}-${var.code}-${var.feature[5]}-public-${var.creator}"
    "Env"     = var.env
    "Code"    = var.code
    "Feature" = var.feature[5]
    "Creator" = var.creator
  }
}

resource "aws_route_table_association" "public_rta" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = element(aws_subnet.public_subnet.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

#App Route Table
resource "aws_route_table" "app_rt" {
  count    = length(aws_subnet.app_subnet)
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(aws_nat_gateway.nat.*.id, count.index)
  }

  tags = {
    "Name"    = "${var.unit}-${var.env}-${var.code}-${var.feature[5]}-app-${var.creator}"
    "Env"     = var.env
    "Code"    = var.code
    "Feature" = var.feature[5]
    "Creator" = var.creator
  }
}

resource "aws_route_table_association" "app_rta" {
  count          = length(aws_subnet.app_subnet)
  subnet_id      = element(aws_subnet.app_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.app_rt.*.id, count.index)
}

#Cache Route Table
resource "aws_route_table" "cache_rt" {
  count    = length(aws_subnet.cache_subnet)
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(aws_nat_gateway.nat.*.id, count.index)
  }

  tags = {
    "Name"    = "${var.unit}-${var.env}-${var.code}-${var.feature[5]}-cache-${var.creator}"
    "Env"     = var.env
    "Code"    = var.code
    "Feature" = var.feature[5]
    "Creator" = var.creator
  }
}

resource "aws_route_table_association" "cache_rta" {
  count          = length(aws_subnet.cache_subnet)
  subnet_id      = element(aws_subnet.cache_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.cache_rt.*.id, count.index)
}

#Database Route Table
resource "aws_route_table" "db_rt" {
  count    = length(aws_subnet.db_subnet)
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(aws_nat_gateway.nat.*.id, count.index)
  }

  tags = {
    "Name"    = "${var.unit}-${var.env}-${var.code}-${var.feature[5]}-db-${var.creator}"
    "Env"     = var.env
    "Code"    = var.code
    "Feature" = var.feature[5]
    "Creator" = var.creator
  }
}

resource "aws_route_table_association" "db_rta" {
  count          = length(aws_subnet.db_subnet)
  subnet_id      = element(aws_subnet.db_subnet.*.id, count.index)
  route_table_id = element(aws_route_table.db_rt.*.id, count.index)
}
