- name: Terraform Init
  run: terraform -chdir=terraform-project-infra init

will correctly initialize the backend, connect to the S3 bucket, and utilize the DynamoDB table for locking, ensuring the lock error is resolved and your deployments are safe.

Let me know if you'd like me to review the full contents of your `terraform-project-infra/` directory or refine the GitHub workflow slightly!
