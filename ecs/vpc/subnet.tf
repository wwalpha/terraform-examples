
# -----------------------------------------------
# AWS Subnet
# -----------------------------------------------
resource "aws_subnet" "public" {
  depends_on        = ["aws_vpc.this"]
  vpc_id            = "${aws_vpc.this.id}"
  cidr_block        = "${element(var.public_subnets, count.index)}"
  availability_zone = "${local.availability_zones[count.index % length(var.public_subnets)]}"

  tags = {
    "Name" = "${var.vpc_name}-PublicSubnet"
  }

  count = "${length(var.public_subnets)}"
}
