resource "aws_vpc" "ecs-vpc" {
  cidr_block = "10.100.0.0/16"
}
