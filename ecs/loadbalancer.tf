module "alb" {
  source = "./load-balancer"
  # source = "github.com/wwalpha/terraform-module-registry/aws/load-balancer"

  vpc_id                   = "${module.vpc.vpc_id}"
  name                     = "${var.lb_name}"
  type                     = "${var.lb_type}"
  port                     = "${var.lb_port}"
  protocol                 = "${var.lb_protocol}"
  security_groups          = ["${module.alb_sg.id}"]
  subnets                  = "${module.vpc.public_subnets}"
  target_group_name        = "${var.lb_target_group_name}"
  target_group_target_type = "${var.lb_target_group_target_type}"
}

# --------------------------------------------------------------------------------
# AWS Load Blance Listener
# --------------------------------------------------------------------------------
resource "aws_lb_listener" "this" {
  load_balancer_arn = "${module.alb.load_balancer_arn}"
  port              = "${var.lb_port}"
  protocol          = "${var.lb_protocol}"

  default_action {
    target_group_arn = "${module.alb.target_group_arn}"
    type             = "forward"
  }

  lifecycle {
    create_before_destroy = false
  }
}
