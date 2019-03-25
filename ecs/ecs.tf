variable "PROJECT" {}
variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "ap-northeast-1"
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = "${terraform.workspace}-${var.PROJECT}-cluster"
}

resource "aws_ecs_task_definition" "fargate_task" {
  family = "fargate_taskdef"

  container_definitions = "${data.aws_ecs_container_definition.ecs-container}"
  cpu                   = "256"
  memory                = "512"
}

data "aws_ecs_container_definition" "ecs-container" {
  container_name  = "ecs-container"
  task_definition = "${aws_ecs_task_definition.fargate_task.id}"
}
