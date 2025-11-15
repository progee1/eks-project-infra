resource "aws_s3_bucket" "artifact_bucket" {
  bucket = "godwin-artifact-bucket-198"

  tags = {
    Name = "Artifact Bucket"
    Environment = "prod"
  }
}

resource "aws_s3_bucket_versioning" "artifact_bucket_versioning" {
  bucket = aws_s3_bucket.artifact_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "artifact_bucket_public_access" {
  bucket = aws_s3_bucket.artifact_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "artifact_bucket_encryption" {
  bucket = aws_s3_bucket.artifact_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_ownership_controls" "artifact_bucket_ownership" {
  bucket = aws_s3_bucket.artifact_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
