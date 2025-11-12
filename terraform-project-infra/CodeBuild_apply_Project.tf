resource "aws_codebuild_project" "apply_stage" {
  name         = "godwin-apply-stage"
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
    buildspec = "buildspec-apply.yml"
  }

  logs_config {
    cloudwatch_logs {
      group_name  = "/aws/codebuild/godwin-apply-stage"
      stream_name = "apply"
    }
  }

  tags = {
    Name  = "godwin-apply-stage"
    Owner = "Godwin"
  }
}
