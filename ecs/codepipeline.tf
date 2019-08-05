resource "aws_codepipeline" "this" {
  name     = "ECSPipeline"
  role_arn = "${aws_iam_role.codepipeline_role.arn}"

  artifact_store {
    location = "ecs-pipeline-artifact-0101"
    type     = "S3"

    # encryption_key {
    #   id   = "${data.aws_kms_alias.s3kmskey.arn}"
    #   type = "KMS"
    # }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["SourceArtifact"]

      configuration = {
        Owner                = "wwalpha"
        Repo                 = "aws-pipeline-ecs"
        Branch               = "master"
        OAuthToken           = "${var.github_token}"
        PollForSourceChanges = false
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["SourceArtifact"]
      output_artifacts = ["BuildArtifact"]
      version          = "1"

      configuration = {
        ProjectName = "ECSCodeBuild"
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["BuildArtifact"]
      version         = "1"

      configuration = {
        # ActionMode     = "REPLACE_ON_FAILURE"
        # Capabilities   = "CAPABILITY_AUTO_EXPAND,CAPABILITY_IAM"
        # OutputFileName = "CreateStackOutput.json"
        # StackName      = "MyStack"
        # TemplatePath   = "build_output::sam-templated.yaml"
        ClusterName = "ecs-cluster"
        ServiceName = "app-service"
      }
    }
  }
}

resource "aws_iam_role" "codepipeline_role" {
  name               = "ECSCodePipelineRole"
  assume_role_policy = "${file("${var.configs_path}/iam/codepipeline_assume_role.json")}"
}

resource "aws_iam_role_policy" "codepipeline_policy" {
  name   = "ECSPipelineRolePolicy"
  role   = "${aws_iam_role.codepipeline_role.id}"
  policy = "${file("${var.configs_path}/iam/codepipeline_role_policy.json")}"
}
