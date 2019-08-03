# -----------------------------------------------
# AWS VPC
# -----------------------------------------------
resource "aws_vpc" "this" {
  cidr_block = "${var.vpc_cidr_block}"

  tags = {
    Name = "${var.vpc_name}"
  }
}

# -----------------------------------------------
# AWS Availability Zones
# -----------------------------------------------
data "aws_availability_zones" "available" {
  state = "available"
}
