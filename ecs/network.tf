resource "aws_vpc" "fargate" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Description = "Created for ECS cluster ecs-cluster"
    Name        = "ECS ecs-cluster - VPC"
  }
}

resource "aws_subnet" "public1" {
  vpc_id     = "${aws_vpc.fargate.id}"
  cidr_block = "10.0.0.0/24"

  tags = {
    "Description" = "Created for ECS cluster ecs-cluster"
    "Name"        = "ECS ecs-cluster - Public Subnet 1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id     = "${aws_vpc.fargate.id}"
  cidr_block = "10.0.1.0/24"

  tags = {
    "Description" = "Created for ECS cluster ecs-cluster"
    "Name"        = "ECS ecs-cluster - Public Subnet 2"
  }
}

# module "network" {
#   source = "terraform-aws-modules/vpc/aws"
#   name   = "${var.prefix}-vpc"
#   cidr   = "${var.vpc_cidr_block}"
#   azs    = "${var.vpc_azs}"

#   map_public_ip_on_launch = false

#   # private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
#   public_subnets = "${var.vpc_public_subnets}"

#   # enable_nat_gateway = true
#   # enable_vpn_gateway = true

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
# }

# # --------------------------------------------------------------------------------
# # Load Blance Security Group
# # --------------------------------------------------------------------------------
resource "aws_security_group" "alb_sg" {
  name        = "EC2ContainerService-ecs-cluster-AlbSecurityGroup-CT8DS5ZPJKU5"
  description = "ELB Allowed Ports"
  vpc_id      = "${aws_vpc.fargate.id}"

  ingress {
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

  tags = {
    "Description" = "Created for ECS cluster ecs-cluster"
    "Name"        = "ECS ecs-cluster - ALB SecurityGroup"
  }
}

resource "aws_security_group_rule" "alb_sg" {
  cidr_blocks = ["0.0.0.0/0"]
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"

  security_group_id = "${aws_security_group.alb_sg.id}"
}

resource "aws_security_group_rule" "alb_sg-1" {
  cidr_blocks = ["0.0.0.0/0"]
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"

  security_group_id = "${aws_security_group.alb_sg.id}"
}

# # --------------------------------------------------------------------------------
# # ECS Security Group
# # --------------------------------------------------------------------------------
resource "aws_security_group" "ecs_sg" {
  name        = "EC2ContainerService-ecs-cluster-EcsSecurityGroup-N9WHVE8AIBQ4"
  description = "ECS Allowed Ports"
  vpc_id      = "${aws_vpc.fargate.id}"

  # ingress {
  #   from_port       = "${var.container_port}"
  #   to_port         = "${var.container_port}"
  #   protocol        = "TCP"
  #   security_groups = ["${aws_security_group.alb_sg.id}"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Description" = "Created for ECS cluster ecs-cluster"
    "Name"        = "ECS ecs-cluster - ECS SecurityGroup"
  }
}

resource "aws_security_group_rule" "ecs_sg" {
  cidr_blocks = ["0.0.0.0/0"]
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"

  security_group_id = "${aws_security_group.ecs_sg.id}"
}

resource "aws_security_group_rule" "ecs_sg-1" {
  cidr_blocks = ["0.0.0.0/0"]
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"

  security_group_id = "${aws_security_group.ecs_sg.id}"
}

resource "aws_security_group_rule" "ecs_sg-2" {
  type      = "ingress"
  from_port = 1
  to_port   = 65535
  protocol  = "tcp"

  security_group_id        = "${aws_security_group.ecs_sg.id}"
  source_security_group_id = "${aws_security_group.alb_sg.id}"
}
