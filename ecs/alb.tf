# --------------------------------------------------------------------------------
# AWS Load Blance
# --------------------------------------------------------------------------------
resource "aws_alb" "alb" {
  name               = "${var.prefix}-alb"
  internal           = false
  load_balancer_type = "application"

  subnets = ["${module.vpc.public_subnets}"]

  tags {
    Name = "${var.prefix}-alb"
  }
}

# --------------------------------------------------------------------------------
# AWS Load Blance Target Group
# --------------------------------------------------------------------------------
resource "aws_alb_target_group" "alb_target_group" {
  depends_on = ["aws_alb.alb"]

  name        = "${var.prefix}-alb-tg"
  target_type = "ip"
  protocol    = "HTTP"
  port        = "${var.container_port}"
  vpc_id      = "${module.vpc.vpc_id}"

  health_check = {
    path = "/"
    port = "${var.container_port}"
  }

  tags {
    Name = "${var.prefix}-alg-tg"
  }
}

# --------------------------------------------------------------------------------
# AWS Load Blance Listener
# --------------------------------------------------------------------------------
resource "aws_lb_listener" "listener" {
  depends_on        = ["aws_alb_target_group.alb_target_group"]
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "${var.container_port}"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
    type             = "forward"
  }
}
