# --------------------------------------------------------------------------------
# Amazon ECS Cluster
# --------------------------------------------------------------------------------
resource "aws_ecs_cluster" "this" {
  name = "${var.ecs_cluster_name}"
}

# --------------------------------------------------------------------------------
# Amazon ECS Task Template
# --------------------------------------------------------------------------------
data "template_file" "container" {
  template = "${file("${var.configs_path}/ecs/container.tpl")}"

  vars = {
    name       = "${var.ecs_task_container_name}"
    image      = "${var.ecs_task_container_image}"
    cpu        = "${var.ecs_task_container_cpu}"
    memory     = "${var.ecs_task_container_memory}"
    log_driver = "${var.ecs_log_driver}"
    log_group  = "${var.ecs_log_group}"
    region     = "${local.region}"
  }
}

# --------------------------------------------------------------------------------
# Amazon ECS Task Definition
# --------------------------------------------------------------------------------
resource "aws_ecs_task_definition" "this" {
  depends_on               = ["aws_iam_role.task"]
  family                   = "${var.ecs_task_family}"
  cpu                      = "${var.ecs_task_container_cpu}"
  memory                   = "${var.ecs_task_container_memory}"
  container_definitions    = "${data.template_file.container.rendered}"
  requires_compatibilities = ["${var.ecs_task_requires_compatibilities}"]
  network_mode             = "awsvpc"
  execution_role_arn       = "${aws_iam_role.task.arn}"
}

# --------------------------------------------------------------------------------
# Amazon ECS Service
# --------------------------------------------------------------------------------
resource "aws_ecs_service" "this" {
  name            = "${var.ecs_service_name}"
  cluster         = "${aws_ecs_cluster.this.id}"
  task_definition = "${local.task_definition}"
  desired_count   = "${var.ecs_desired_count}"
  launch_type     = "${var.ecs_launch_type}"

  health_check_grace_period_seconds = 0

  deployment_controller {
    type = "ECS"
  }

  network_configuration {
    assign_public_ip = true
    subnets          = "${module.vpc.public_subnets}"
    security_groups  = ["${module.ecs_sg.id}"]
  }

  load_balancer {
    target_group_arn = "${module.alb.target_group_arn}"
    container_name   = "${var.ecs_task_container_name}"
    container_port   = "${var.ecs_task_container_port}"
  }
}

# --------------------------------------------------------------------------------
# ECS Task Execute Role
# --------------------------------------------------------------------------------
resource "aws_iam_role" "task" {
  name               = "${var.ecs_cluster_name}Role"
  assume_role_policy = "${file("${var.configs_path}/iam/ecs_assume_policy.json")}"
}

resource "aws_iam_role_policy_attachment" "task" {
  role       = "${aws_iam_role.task.name}"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
