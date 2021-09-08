terraform {
  backend "s3" {
    bucket  = "avn-dev-storage-s3-terraform"
    region  = "ap-southeast-2"
    key     = "avn-core-api-dev.tfstate"
    profile = "avn-dev"
  }
}

data "template_file" "iam_role_task_policy" {
  template = file("task_policy.json")
}

module "deployment" {
  source                   = "../../modules/deployment"
  region                   = "ap-southeast-2"
  unit                     = "avn"
  env                      = "dev"
  code                     = "core"
  feature                  = "api"
  requires_compatibilities = ["FARGATE"]
  cpu                      = 128
  memory                   = 512
  memory_reservation       = 128
  container_port           = 80
  protocol                 = "TCP"
  target_type              = "ip"
  deregistration_delay     = "30"
  health_check_interval    = "60"
  healthy_threshold        = 5
  unhealthy_threshold      = 5
  network_mode             = "awsvpc"
  launch_type              = "FARGATE"
  iam_policy               = data.template_file.iam_role_task_policy.rendered
  predefined_metric_type   = ["ECSServiceAverageCPUUtilization"]
  min_capacity             = 2
  max_capacity             = 8
  target_value             = [175]
  policy_type              = "TargetTrackingScaling"
  scale_in_cooldown        = 15
  scale_out_cooldown       = 5
}
