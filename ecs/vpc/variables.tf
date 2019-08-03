variable "vpc_name" {}
variable "vpc_cidr_block" {}
variable "public_subnets" {
  type    = "list"
  default = []
}
variable "private_subnets" {
  type    = "list"
  default = []
}
variable "availability_zones" {
  type    = "list"
  default = []
}
