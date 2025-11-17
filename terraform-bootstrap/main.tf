#
# This configuration is designed to run ONLY the first time to create 
# the necessary backend resources for the main project.
#
# Since the S3 bucket 'godwin-terraform-state-bucket198' already exists,
# we focus on creating the missing DynamoDB lock table and ensuring 
# the required S3 bucket configurations are applied.
#

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# --- 1. DynamoDB Table for State Locking (Creation target) ---
# This resource creates the missing lock table.
resource "aws_dynamodb_table" "lock_table" {
  name           = "godwin-terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "terraform-locks-godwin"
  }
}

# --- 2. S3 Bucket Configurations (Applied to existing bucket) ---
# We use separate resources to configure the existing bucket without trying to create it.

# Enable Versioning on the existing S3 bucket
resource "aws_s3_bucket_versioning" "tfstate_versioning" {
  bucket = "godwin-terraform-state-bucket198"
  versioning_configuration {
    status = "Enabled"
  }
}

# Apply Server-Side Encryption (AES256) on the existing S3 bucket
resource "aws_s3_bucket_server_side_encryption_configuration" "tfstate_sse" {
  bucket = "godwin-terraform-state-bucket198"
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
  depends_on = [aws_s3_bucket_versioning.tfstate_versioning]
}

# Block all Public Access on the existing S3 bucket
resource "aws_s3_bucket_public_access_block" "tfstate_block" {
  bucket                  = "godwin-terraform-state-bucket198"
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  depends_on              = [aws_s3_bucket_server_side_encryption_configuration.tfstate_sse]
}
