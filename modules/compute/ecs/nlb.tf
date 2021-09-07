
resource "aws_security_group" "nlb_sg" {
  name        = "${var.unit}-${var.env}-${var.code}-${var.feature[0]}-nlb-sg-${var.creator}"
  description = "Security Group for Network Load Balancer"
  vpc_id      = data.terraform_remote_state.avn_network.outputs.network_vpc_id
  tags = {
    Name      = "${var.unit}-${var.env}-${var.code}-${var.feature[0]}-nlb-sg-${var.creator}"
    "Env"     = var.env
    "Code"    = var.code
    "Feature" = "${var.feature[0]}-nlb-sg"
    "Creator" = var.creator
  }
}

resource "aws_security_group_rule" "nlb_sg_in_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nlb_sg.id
  description       = "Allow ingress http"
}

resource "aws_security_group_rule" "nlb_sg_in_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nlb_sg.id
  description       = "Allow ingress https"
}

resource "aws_security_group_rule" "nlb_sg_eg_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.nlb_sg.id
  description       = "Allow egress all protocol"
}

resource "aws_eip" "nlb_eip" {
  count = var.total_eip
  vpc   = true

  tags = {
    "Name"    = "${var.unit}-${var.env}-${var.code}-${var.feature[0]}-nlb-eip-${var.creator}-${count.index}"
    "Env"     = var.env
    "Code"    = var.code
    "Feature" = "${var.feature[0]}-nlb-eip"
    "Creator" = var.creator
  }
}

resource "aws_lb" "nlb" {
  name                             = "${var.unit}-${var.env}-${var.code}-${var.feature[0]}-nlb-${var.creator}"
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing

  dynamic "subnet_mapping" {
    for_each = data.terraform_remote_state.avn_network.outputs.network_public_subnet_id
    content {
      subnet_id     = subnet_mapping.value
      allocation_id = aws_eip.nlb_eip[subnet_mapping.key].id
    }
  }
}

resource "aws_lb_target_group" "nlb_tg" {
  name                 = "${var.unit}-${var.env}-${var.code}-${var.feature[0]}-nlb-tg-${var.creator}"
  port                 = var.nlb_port
  protocol             = var.nlb_protocol
  vpc_id               = data.terraform_remote_state.avn_network.outputs.network_vpc_id
  target_type          = var.target_type
  deregistration_delay = var.deregistration_delay

  health_check {
    protocol            = var.nlb_protocol
    interval            = var.health_check_interval
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }

  tags = {
    "Name"    = "${var.unit}-${var.env}-${var.code}-${var.feature[0]}-nlb-tg-${var.creator}"
    "Env"     = var.env
    "Code"    = var.code
    "Feature" = "${var.feature[0]}-nlb-tg"
    "Creator" = var.creator
  }
}

resource "aws_lb_listener" "nlb_http_listener" {
  load_balancer_arn = aws_lb.nlb.arn
  port              = var.nlb_port
  protocol          = var.nlb_protocol

  default_action {
    target_group_arn = aws_lb_target_group.nlb_tg.id
    type             = "forward"
  }
}
