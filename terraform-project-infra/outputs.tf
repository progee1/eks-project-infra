output "eks_cluster_name" {
  value = aws_eks_cluster.godwin_cluster.name
}

output "artifact_bucket" {
  value = aws_s3_bucket.artifact_bucket.bucket
}

output "dynamodb_table" {
  value = aws_dynamodb_table.tf_lock.name
}

output "pipeline_name" {
  value = aws_codepipeline.infra_pipeline.name
}
