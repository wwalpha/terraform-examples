# --------------------------------------------------------------------------------
# ECS Security Group - Application Load Balancer
# --------------------------------------------------------------------------------
module "alb_sg" {
  # source = "./security-group"
  source = "github.com/wwalpha/terraform-module-registry/aws/security-group"

  vpc_id = "${module.vpc.vpc_id}"
  name   = "${var.alb_security_group_name}"
  rules = [
    {
      cidr_blocks = "0.0.0.0/0"
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
    },
    {
      cidr_blocks = "0.0.0.0/0"
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
    }
  ]
}

# --------------------------------------------------------------------------------
# ECS Security Group
# --------------------------------------------------------------------------------
module "ecs_sg" {
  # source = "./security-group"
  source = "github.com/wwalpha/terraform-module-registry/aws/security-group"

  vpc_id = "${module.vpc.vpc_id}"
  name   = "${var.ecs_security_group_name}"
  rules = [
    {
      cidr_blocks = "0.0.0.0/0"
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
    },
    {
      cidr_blocks = "0.0.0.0/0"
      type        = "ingress"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
    }
  ]
  rules_with_source_security_group_id = [
    {
      type                     = "ingress"
      from_port                = 1
      to_port                  = 65535
      protocol                 = "tcp"
      source_security_group_id = "${module.alb_sg.id}"
    }
  ]
}
