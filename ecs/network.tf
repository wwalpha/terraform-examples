module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "${var.prefix}-vpc"
  cidr   = "${var.vpc_cidr_block}"
  azs    = "${var.vpc_azs}"

  # private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets = "${var.vpc_public_subnets}"

  # enable_nat_gateway = true
  # enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "public_security_group" {
  name   = "${var.prefix}-sg"
  vpc_id = "${module.vpc.vpc_id}"

  egress = {
    from_port   = "${var.container_port}"
    to_port     = "${var.container_port}"
    protocol    = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
