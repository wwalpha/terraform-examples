resource "aws_ecr_repository" "ecr" {
  name = "${var.prefix}-ecr"
}
