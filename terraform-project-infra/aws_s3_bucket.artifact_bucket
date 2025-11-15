resource "aws_s3_bucket" "artifact_bucket" {
  bucket        = "godwin-artifact-bucket-198"
  force_destroy = true
}
tags = {
    Name  = "godwin-artifact-bucket"
    Owner = "Godwin"
  }

resource "aws_s3_bucket_policy" "artifact_bucket_policy" {
  bucket = aws_s3_bucket.artifact_bucket.id

  policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Sid: "CodePipelineAccess",
        Effect: "Allow",
        Principal: {
          Service: [
            "codepipeline.amazonaws.com",
            "codebuild.amazonaws.com",
            "codeapply.amazonaws.com"
          ]
        },
        Action : [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        Resource : [
          aws_s3_bucket.artifact_bucket.arn,
          "${aws_s3_bucket.artifact_bucket.arn}/*"
        ]
      }
    ]
  })
}
