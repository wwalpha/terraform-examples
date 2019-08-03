# --------------------------------------------------------------------------------
# Amazon ECS Cluster
# --------------------------------------------------------------------------------
resource "aws_ecs_cluster" "fargate" {
  name = "${var.ecs_cluster_name}"
}

# module "container_definitions" {
#   source  = "cloudposse/ecs-container-definition/aws"
#   version = "0.10.0"

#   container_image              = "${var.container_image}"
#   container_name               = "${var.container_name}"
#   essential                    = "${var.essential}"
#   container_cpu                = "${var.container_cpu}"
#   container_memory             = "${var.container_memory}"
#   container_memory_reservation = "${var.container_memory_reservation}"

#   # entrypoint                   = "${var.entrypoint}"
#   # command                      = "${var.command}"

#   # Fargate only awslog
#   # log_driver                   = "${local.log_driver}"
#   # log_options                  = "${local.log_options}"
#   port_mappings = "${local.port_mappings}"
#   healthcheck              = "${var.healthcheck}"
#   dns_servers              = "${var.dns_servers}"
#   environment              = "${var.environment}"
#   secrets                  = "${var.secrets}"
#   working_directory        = "${var.working_directory}"
#   readonly_root_filesystem = "${var.readonly_root_filesystem}"
#   mount_points             = "${var.mount_points}"
# }

# --------------------------------------------------------------------------------
# Amazon ECS Task Definition
# --------------------------------------------------------------------------------
data "template_file" "ecs_service" {
  template = "${file("${var.configs_path}/ecs/service.tpl")}"

  vars = {
    name       = "${var.container_name}"
    image      = "${var.container_image}"
    cpu        = "${var.container_cpu}"
    memory     = "${var.container_memory}"
    log_driver = "${var.ecs_log_driver}"
    log_group  = "${var.ecs_log_group}"
    region     = "${local.region}"
  }
}

resource "aws_ecs_task_definition" "fargate" {
  # depends_on = ["aws_iam_role.ecs_task_exec_role"]
  family = "first-run-task-definition"

  container_definitions = "${data.template_file.ecs_service.rendered}"

  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.container_cpu}"
  memory                   = "${var.container_memory}"
  network_mode             = "awsvpc"

  execution_role_arn = "${aws_iam_role.ecs_task_exec_role.arn}"
  # task_role_arn      = "${aws_iam_role.ecs_task_exec_role.arn}"
}

# --------------------------------------------------------------------------------
# Amazon ECS Service
# --------------------------------------------------------------------------------
resource "aws_ecs_service" "fargate" {
  name            = "${var.ecs_service_name}"
  cluster         = "${aws_ecs_cluster.fargate.id}"
  task_definition = "${aws_ecs_task_definition.fargate.arn}"
  desired_count   = 1
  launch_type     = "FARGATE"

  health_check_grace_period_seconds = 0
  # depends_on = [
  #   "aws_ecs_cluster.cluster",
  #   "aws_ecs_task_definition.task",
  #   "aws_alb_target_group.alb_target_group",
  # ]

  # network_configuration = {
  #   subnets = ["${module.network.public_subnets}"]

  #   security_groups = ["${aws_security_group.ecs_sg.id}"]

  #   assign_public_ip = true
  # }

  # load_balancer {
  #   target_group_arn = "${aws_alb_target_group.alb_target_group.arn}"
  #   container_name   = "${var.container_name}"
  #   container_port   = "${var.container_port}"
  # }
}

# --------------------------------------------------------------------------------
# ECS Task Execute Role
# --------------------------------------------------------------------------------
resource "aws_iam_role" "ecs_task_exec_role" {
  name               = "ecsTaskExecutionRole"
  assume_role_policy = "${file("${var.configs_path}/iam/ecs_task_exec_role.json")}"
}

# resource "aws_iam_policy" "ecs_task_exec_policy" {
#   name   = "ECSTaskExecutionPolicy"
#   policy = "${file("${var.configs_path}/iam/ecs_task_exec_policy.json")}"
# }

# resource "aws_iam_policy_attachment" "ecs_task_exec_role_policy_attach" {
#   name       = "AmazonECSTaskExecutionRolePolicyAttach"
#   roles      = ["${aws_iam_role.ecs_task_exec_role.name}"]
#   policy_arn = "${aws_iam_policy.ecs_task_exec_policy.arn}"
# }
