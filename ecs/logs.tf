# # --------------------------------------------------------------------------------
# # Amazon ECS Cluster
# # --------------------------------------------------------------------------------
# resource "aws_cloudwatch_log_group" "log_group" {
#   name              = "${var.ecs_log_group}"
#   retention_in_days = "30"

#   tags {
#     Name = "${var.prefix}-log-group"
#   }
# }

# resource "aws_cloudwatch_log_stream" "log_stream" {
#   name           = "${var.prefix}-log-stream}"
#   log_group_name = "${aws_cloudwatch_log_group.log_group.name}"
# }
