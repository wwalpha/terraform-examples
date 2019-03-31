# --------------------------------------------------------------------------------
# CodeBuild Project
# --------------------------------------------------------------------------------
resource "aws_codebuild_project" "codebuild" {
  name = "${var.prefix}-${var.project_name}"

  # description   = "${var.project_description}"
  build_timeout = "${var.build_timeout}"
  service_role  = "${aws_iam_role.codebuild_service_role.arn}"

  source {
    type            = "GITHUB"
    location        = "${var.github_repo}"
    git_clone_depth = "${var.github_clone_depth}"
    buildspec       = "${var.build_spec}"
  }

  cache {
    type     = "S3"
    location = "${aws_s3_bucket.codebuild_cache.bucket}"
  }

  artifacts {
    type = "${var.artifacts_type}"
  }

  environment {
    compute_type    = "${local.compute_type}"
    image           = "${var.builder_image}"
    type            = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable = "${var.build_env_vars}"
  }

  tags = "${var.project_tags}"

  # count = "${var.github_count}"
}

# --------------------------------------------------------------------------------
# CodeBuild Service Role
# --------------------------------------------------------------------------------
data "template_file" "code_build_policy_tpl" {
  template = "${file("${var.configs_path}/iam/codebuild_policy.tpl")}"

  vars = {
    region    = "${var.region}"
    log_group = "${local.codebuild_log_group}"
  }
}

resource "aws_iam_role" "codebuild_service_role" {
  name               = "${var.prefix}-codebuild-role"
  assume_role_policy = "${file("${var.configs_path}/iam/codebuild_role.json")}"
}

resource "aws_iam_policy" "codebuild_service_policy" {
  name   = "${var.project_name}CodeBuildPolicy"
  policy = "${data.template_file.code_build_policy_tpl.rendered}"
}

resource "aws_iam_policy_attachment" "codebuild_service_policy_attach" {
  name       = "CodebuildServicePolicy"
  roles      = ["${aws_iam_role.codebuild_service_role.name}"]
  policy_arn = "${aws_iam_policy.codebuild_service_policy.arn}"
}
