resource "aws_vpc" "vpc" {
  cidr_block = "${var.vpc_cidr_block}"

  tags = {
    Name = "${local.prefix}-vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.public1_cidr_block}"

  tags = {
    Name = "public-az1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = "${aws_vpc.vpc.id}"
  cidr_block = "${var.public2_cidr_block}"

  tags = {
    Name = "public-az2"
  }
}
