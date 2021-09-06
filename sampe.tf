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
    "Feature" = var.feature[2]
    "Creator" = var.creator
  }
}

resource "aws_route_table_association" "db_rta" {
  count          = length(aws_subnet.db_subnet)
  subnet_id      = element(aws_subnet.db_subnet.*.id, count.index)
  route_table_id = aws_route_table.db_rt.id
}