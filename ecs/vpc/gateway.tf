# -----------------------------------------------
# AWS Internet Gateway
# -----------------------------------------------
resource "aws_internet_gateway" "this" {
  vpc_id = "${aws_vpc.this.id}"

  # count = "${length(var.public_subnets) != 0 ? 1 : 0}"
  count = "1"
}
