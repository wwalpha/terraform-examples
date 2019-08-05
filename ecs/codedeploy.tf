# resource "aws_codedeploy_app" "this" {
#   compute_platform = "ECS"
#   name             = "ECSDeploy"
# }

# resource "aws_codedeploy_deployment_group" "this" {
#   app_name              = "${aws_codedeploy_app.this.name}"
#   deployment_group_name = "example-group"
#   service_role_arn      = "${aws_iam_role.this.arn}"

#   ec2_tag_set {
#     ec2_tag_filter {
#       key   = "filterkey1"
#       type  = "KEY_AND_VALUE"
#       value = "filtervalue"
#     }

#     ec2_tag_filter {
#       key   = "filterkey2"
#       type  = "KEY_AND_VALUE"
#       value = "filtervalue"
#     }
#   }

#   auto_rollback_configuration {
#     enabled = true
#     events  = ["DEPLOYMENT_FAILURE"]
#   }

#   alarm_configuration {
#     alarms  = ["my-alarm-name"]
#     enabled = true
#   }
# }

# resource "aws_iam_role" "this" {
#   name = "example-role"

#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Sid": "",
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "codedeploy.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
#   role = "${aws_iam_role.this.name}"
# }
