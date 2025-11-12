###############################################
# MAIN INFRASTRUCTURE ENTRYPOINT
# Project: eks-project-infra
# Owner: Godwin
###############################################

terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

###############################################
# GLOBAL TAGS
###############################################

locals {
  common_tags = {
    Project = "Godwin"
    Owner   = "Godwin"
  }
}

###############################################
# RESOURCE IMPORTS
###############################################

# Include the following resource definitions:
# - provider.tf defines the backend (S3 + DynamoDB)
# - s3_artifact_bucket.tf creates S3 bucket + policy
# - dynamodb.tf creates DynamoDB lock table
# - eks_cluster.tf creates EKS cluster + node group
# - CodeBuild_Build_Project.tf defines build project
# - CodeBuild_Deploy_Project.tf defines deploy project
# - codepipeline.tf defines 3-stage pipeline