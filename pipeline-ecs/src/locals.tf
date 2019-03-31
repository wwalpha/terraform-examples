locals {
  compute_type_map {
    small  = "BUILD_GENERAL1_SMALL"
    medium = "BUILD_GENERAL1_MEDIUM"
    large  = "BUILD_GENERAL1_LARGE"
  }
}

locals {
  prefix = "${var.prefix == "" ? var.prefix : "${var.prefix}-"}"

  compute_type = "${lookup(local.compute_type_map, var.builder_size)}"

  codebuild_log_group = "/aws/codebuild/${var.project_name}"
}
