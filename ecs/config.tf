terraform {
  backend "s3" {
    bucket  = "wwalpha-terraform"
    region  = "ap-northeast-1"
    profile = "${var.aws_profile}"
    key     = "ecs"
  }
}