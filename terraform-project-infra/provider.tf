terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }

  backend "s3" {
    bucket         = var.tfstate_bucket_name    # bootstrap this bucket (or create manually then init)
    key            = "global/${var.project_name}/terraform.tfstate"
    region         = var.region
    dynamodb_table = var.tf_lock_table_name
    encrypt        = true
  }
}

provider "aws" {
  region = var.region
  # Authentication options (choose one):
  # - Environment variables AWS_ACCESS_KEY_ID & AWS_SECRET_ACCESS_KEY
  # - ~/.aws/credentials profile (set AWS_PROFILE)
  # - GitHub Actions OIDC (recommended for CI)
  # DO NOT hard-code credentials here.
}
