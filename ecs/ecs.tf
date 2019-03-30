resource "aws_ecs_cluster" "cluster" {
  name = "${var.prefix}-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                = "${var.prefix}-task"
  container_definitions = "${file("configs/ecs/service.json")}"

  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.container_cpu}"
  memory                   = "${var.container_memory}"
  network_mode             = "awsvpc"

  execution_role_arn = "${aws_iam_role.ecs_task_exec_role.arn}"
  task_role_arn      = "${aws_iam_role.ecs_task_exec_role.arn}"
}

resource "aws_ecs_service" "service" {
  name            = "${var.prefix}-service"
  cluster         = "${aws_ecs_cluster.cluster.id}"
  task_definition = "${aws_ecs_task_definition.task.arn}"
  desired_count   = 1
  launch_type     = "FARGATE"

  depends_on = [
    "aws_ecs_cluster.cluster",
    "aws_ecs_task_definition.task",
  ]

  network_configuration = {
    subnets = ["${module.vpc.public_subnets}"]

    security_groups = [
      "${aws_security_group.public_security_group.id}",
    ]

    assign_public_ip = true
  }
}

resource "aws_iam_role" "ecs_task_exec_role" {
  name               = "${var.prefix}-ecs-task-execution-role"
  assume_role_policy = "${file("configs/iam/ECSTaskExecRole.json")}"
}
