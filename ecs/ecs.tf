resource "aws_ecs_cluster" "cluster" {
  name = "${local.prefix}-cluster"
}

resource "aws_ecs_task_definition" "task" {
  family                = "${local.prefix}-task"
  container_definitions = "${file("task-definitions/service.json")}"

  requires_compatibilities = ["FARGATE"]
  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"
}

resource "aws_ecs_service" "service" {
  name            = "${local.prefix}-service"
  cluster         = "${aws_ecs_cluster.cluster.id}"
  task_definition = "${aws_ecs_task_definition.task.arn}"
  desired_count   = 1
  launch_type     = "FARGATE"

  depends_on = [
    "aws_ecs_cluster.cluster",
    "aws_ecs_task_definition.task",
  ]

  network_configuration = {
    subnets = [
      "${aws_subnet.public_subnet_1.id}",
      "${aws_subnet.public_subnet_2.id}",
    ]
  }
}
