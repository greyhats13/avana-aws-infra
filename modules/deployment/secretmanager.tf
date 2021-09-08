resource "aws_secretsmanager_secret" "secret" {
  name = "${var.unit}-${var.env}-${var.code}-${var.feature}"
}