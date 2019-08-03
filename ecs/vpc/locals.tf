locals {
  availability_zones = "${length(var.availability_zones) != 0 ? var.availability_zones : data.aws_availability_zones.available.names}"
}
