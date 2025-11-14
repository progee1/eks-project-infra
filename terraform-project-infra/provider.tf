
terraform {
  backend "s3" {
    bucket         = "godwin-terraform-state-bucket198"
    key            = "global/godwin/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "godwin-terraform-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
  # Authentication options (choose one):
  # - Environment variables AWS_ACCESS_KEY_ID & AWS_SECRET_ACCESS_KEY
  # - ~/.aws/credentials profile (set AWS_PROFILE)
  # - GitHub Actions OIDC (recommended for CI)
  # DO NOT hard-code credentials here.
}
