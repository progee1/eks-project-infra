resource "aws_dynamodb_table" "tf_lock" {
  name         = "godwin-terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name  = "godwin-terraform-lock"
    Owner = "Godwin"
  }
}
