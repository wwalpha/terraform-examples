resource "aws_s3_bucket" "codebuild_cache" {
  bucket = "${var.prefix}-codebuild-cache"
  acl    = "private"
}
