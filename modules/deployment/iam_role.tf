resource "aws_iam_role" "role" {
  name = "${var.unit}-${var.env}-${var.code}-${var.feature}-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "policy" {
  name   = "${var.unit}-${var.env}-${var.code}-${var.feature}-policy-name"
  role   = aws_iam_role.role.id
  policy = var.iam_policy
}

resource "aws_ssm_parameter" "role_arn" {
  name        = "/${var.unit}/${var.env}/secret/${var.code}/${var.feature}/IAM_ROLE_ARN"
  type        = "SecureString"
  value       = aws_iam_role.role.arn
}