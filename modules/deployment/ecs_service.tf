resource "aws_ecs_task_definition" "task_definition" {
  family                    = "${var.unit}-${var.env}-${var.code}-${var.feature}"
  requires_compatibilities  = var.requires_compatibilities
  task_role_arn             = aws_iam_role.ecs_task_role.arn
  execution_role_arn        = local.td_task_execution_role_arn
  network_mode              = var.network_mode
  container_definitions     = data.template_file.container_definitions.rendered
}