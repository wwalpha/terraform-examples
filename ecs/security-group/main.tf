# --------------------------------------------------------------------------------
# Load Blance Security Group
# --------------------------------------------------------------------------------
resource "aws_security_group" "this" {
  name        = "${var.name}"
  description = "${var.description}"
  vpc_id      = "${var.vpc_id}"

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_security_group_rule" "this" {
  cidr_blocks = ["${lookup(element(var.rules, count.index), "cidr_blocks")}"]
  type        = "${lookup(element(var.rules, count.index), "type")}"
  from_port   = "${lookup(element(var.rules, count.index), "from_port")}"
  to_port     = "${lookup(element(var.rules, count.index), "to_port")}"
  protocol    = "${lookup(element(var.rules, count.index), "protocol")}"

  security_group_id = "${aws_security_group.this.id}"

  count = "${length(var.rules)}"
}

resource "aws_security_group_rule" "ingress" {
  type      = "${lookup(element(var.rules_with_source_security_group_id, count.index), "type")}"
  from_port = "${lookup(element(var.rules_with_source_security_group_id, count.index), "from_port")}"
  to_port   = "${lookup(element(var.rules_with_source_security_group_id, count.index), "to_port")}"
  protocol  = "${lookup(element(var.rules_with_source_security_group_id, count.index), "protocol")}"

  security_group_id        = "${aws_security_group.this.id}"
  source_security_group_id = "${lookup(element(var.rules_with_source_security_group_id, count.index), "source_security_group_id")}"

  count = "${length(var.rules_with_source_security_group_id)}"
}
