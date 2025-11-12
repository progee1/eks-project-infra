resource "aws_codebuild_project" "build_stage" {
  name         = "godwin-build-stage"
  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type        = "BUILD_GENERAL1_SMALL"
    image               = "aws/codebuild/standard:6.0"
    type                = "LINUX_CONTAINER"
    privileged_mode     = true
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = "buildspec-build.yml"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/godwin-build-stage"
      stream_name = "build"
    }
  }

  tags = {
    Name  = "godwin-build-stage"
    Owner = "Godwin"
  }
}
