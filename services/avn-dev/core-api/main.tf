data "template_file" "iam_role_custom_policy" {
  template = file("custom_policy.json")
}

module "deployment" {
  source                           = "../../../modules/deployment"
  region                           = "ap-southeast-1"
  unit                             = "avn"
  env                              = "dev"
  code                             = "core"
  feature                          = "api"
  requires_compatibilities         = "FARGATE"
}