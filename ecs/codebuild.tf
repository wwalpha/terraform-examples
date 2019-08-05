# --------------------------------------------------------------------------------
# CodeBuild Project
# --------------------------------------------------------------------------------
resource "aws_codebuild_project" "this" {
  name = "ECSCodeBuild"

  build_timeout = "60"
  service_role  = "${aws_iam_role.codebuild_role.arn}"

  artifacts {
    type      = "CODEPIPELINE"
    packaging = "NONE"
  }

  source {
    type            = "CODEPIPELINE"
    git_clone_depth = "0"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:2.0"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = false
    type                        = "LINUX_CONTAINER"
  }

  # tags = "${var.project_tags}"

  # count = "${var.github_count}"
}

resource "aws_iam_role" "codebuild_role" {
  name               = "ECSCodeBuildRole"
  assume_role_policy = "${file("${var.configs_path}/iam/codebuild_assume_role.json")}"
}

resource "aws_iam_role_policy" "codebuild_role_policy" {
  name   = "ECSCodeBuildRolePolicy"
  role   = "${aws_iam_role.codebuild_role.id}"
  policy = "${file("${var.configs_path}/iam/codebuild_role_policy.json")}"
}
