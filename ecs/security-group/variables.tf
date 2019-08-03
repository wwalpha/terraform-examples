
variable "name" {
}
variable "vpc_id" {
}
variable "description" {
  default = null
}
variable "rules" {
  type    = list(map(string))
  default = []
}
variable "rules_with_source_security_group_id" {
  type    = list(map(string))
  default = []
}
