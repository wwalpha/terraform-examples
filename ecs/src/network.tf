module "network" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "${var.prefix}-vpc"
  cidr   = "${var.vpc_cidr_block}"
  azs    = "${var.vpc_azs}"

  map_public_ip_on_launch = false

  # private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets = "${var.vpc_public_subnets}"

  # enable_nat_gateway = true
  # enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# --------------------------------------------------------------------------------
# Load Blance Security Group
# --------------------------------------------------------------------------------
resource "aws_security_group" "lb_sg" {
  name   = "${var.prefix}-lb-sg"
  vpc_id = "${module.network.vpc_id}"

  ingress = {
    from_port   = "${var.container_port}"
    to_port     = "${var.container_port}"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.prefix}-lb-sg"
  }
}

# --------------------------------------------------------------------------------
# ECS Security Group
# --------------------------------------------------------------------------------
resource "aws_security_group" "ecs_sg" {
  name   = "${var.prefix}-sg"
  vpc_id = "${module.network.vpc_id}"

  ingress = {
    from_port       = "${var.container_port}"
    to_port         = "${var.container_port}"
    protocol        = "TCP"
    security_groups = ["${aws_security_group.lb_sg.id}"]
  }

  egress = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-sg"
  }
}
