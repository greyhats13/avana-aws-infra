# Cloudwatch Group
resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/service/${var.code}/${var.feature}"
  retention_in_days = 30
}
