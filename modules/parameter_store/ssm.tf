provider "aws" {
  region  = var.region
  profile = "${var.unit}-${var.env}"
}

resource "aws_ssm_parameter" "ssm" {
  for_each  = var.cloudflare
  name      = "/${var.unit}/${var.env}/secret/${var.code}/${var.feature}/${each.key}"
  type      = "SecureString"
  value     = each.value
  overwrite = var.overwrite
}
