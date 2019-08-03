# -----------------------------------------------
# AWS Route Table
# -----------------------------------------------
resource "aws_route_table" "this" {
  depends_on = ["aws_internet_gateway.this"]
  vpc_id     = "${aws_vpc.this.id}"

  tags = {
    Name = "main"
  }
}

# -----------------------------------------------
# AWS Route
# -----------------------------------------------
resource "aws_route" "internet" {
  depends_on             = ["aws_route_table.this"]
  route_table_id         = "${aws_route_table.this.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${element(aws_internet_gateway.this.*.id, 0)}"

  count = "${length(var.public_subnets)}"
}

resource "aws_route_table_association" "public" {
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.this.id}"

  count = "${length(var.public_subnets)}"
}
