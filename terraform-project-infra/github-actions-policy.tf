# GitHub Actions Policy
resource "aws_iam_policy" "github_actions_policy" {
  name        = "GitHubActionsPolicy"
  description = "Allows GitHub Actions to access S3 backend and DynamoDB lock table"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement: [
      {
        Effect = "Allow",
        Action: [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource: [
          "arn:aws:s3:::godwin-terraform-state-bucket198",
          "arn:aws:s3:::godwin-terraform-state-bucket198/*"
        ]
      },
      {
        Effect = "Allow",
        Action: [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:UpdateItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ],
        Resource: "arn:aws:dynamodb:us-east-1:666053141215:table/godwin-terraform-lock"
      }
    ]
  })
}

# Attach policy to GitHub OIDC Role
resource "aws_iam_role_policy_attachment" "attach_github_actions_policy" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.github_actions_policy.arn
}
