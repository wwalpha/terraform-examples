# --------------------------------------------------------------------------------
# AWS Load Blance
# --------------------------------------------------------------------------------
resource "aws_lb" "this" {
  name               = "${var.name}"
  internal           = "${var.internal}"
  load_balancer_type = "${var.type}"
  subnets            = "${var.subnets}"
  security_groups    = "${var.security_groups}"
}

# --------------------------------------------------------------------------------
# AWS Load Blance Target Group
# --------------------------------------------------------------------------------
resource "aws_lb_target_group" "this" {
  name        = "${var.tg_name}"
  target_type = "${var.tg_target_type}"
  protocol    = "${var.protocol}"
  port        = "${var.port}"
  vpc_id      = "${var.vpc_id}"

  health_check {
    path                = "${var.tg_health_check_path}"
    port                = "${var.tg_health_check_port}"
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  tags = {
    Name = "${var.tg_name}"
  }
}

# --------------------------------------------------------------------------------
# AWS Load Blance Listener
# --------------------------------------------------------------------------------
resource "aws_lb_listener" "this" {
  depends_on        = ["aws_lb_target_group.this"]
  load_balancer_arn = "${aws_lb.this.arn}"
  port              = "${var.port}"
  protocol          = "${aws_lb_target_group.this.protocol}"

  default_action {
    target_group_arn = "${aws_lb_target_group.this.arn}"
    type             = "forward"
  }
}
