module "alb" {
  # source = "./load-balancer"
  source = "github.com/wwalpha/terraform-module-registry/aws/load-balancer"

  vpc_id          = "${module.vpc.vpc_id}"
  name            = "${var.lb_name}"
  type            = "${var.lb_type}"
  port            = "${var.lb_port}"
  protocol        = "${var.lb_protocol}"
  security_groups = ["${module.alb_sg.id}"]
  subnets         = "${module.vpc.public_subnets}"
  tg_name         = "${var.lb_target_group_name}"
  tg_target_type  = "${var.lb_target_group_target_type}"
}
