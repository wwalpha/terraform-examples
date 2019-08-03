variable "vpc_id" {}
variable "name" {}
variable "type" {}
variable "port" {}
variable "protocol" {}
variable "security_groups" {
  type = "list"
}
variable "internal" {
  default = false
}
variable "subnets" {
  type = "list"
}
variable "tg_name" {}
variable "tg_target_type" {}
variable "tg_health_check_path" {
  default = "/"
}
variable "tg_health_check_port" {
  default = "traffic-port"
}
