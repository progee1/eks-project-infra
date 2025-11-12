variable "region" {
  type    = string
  default = "us-east-1"
}

variable "aws_account_id" {
  type = string
  description = "Your AWS account id (replace)"
}

variable "project_name" {
  type    = string
  default = "eks-project-infra"
}

variable "tfstate_bucket_name" {
  type    = string
  default = "godwin-terraform-state-<unique>" # replace with globally unique name
}

variable "tf_lock_table_name" {
  type    = string
  default = "godwin-terraform-lock"
}

variable "artifact_bucket_name" {
  type    = string
  default = "godwin-artifacts-<unique>" # replace
}

variable "github_owner" {
  type = string
  description = "GitHub username or org that owns the repos"
}

variable "github_repo_infra" {
  type = string
  default = "eks-project-infra"
}

variable "github_repo_backend" {
  type = string
  default = "my-backend"
}

variable "github_repo_frontend" {
  type = string
  default = "my-frontend"
}

variable "codebuild_image" {
  type = string
  default = "aws/codebuild/standard:7.0"
}
