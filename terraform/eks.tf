module "eks_data_addons" {
  source = "aws-ia/eks-data-addons/aws"
  version = "~> 1.0" # ensure to update this to the latest/desired version

  oidc_provider_arn = module.eks.oidc_provider_arn

  # Example to deploy AWS Neuron Device Plugin for Trainium and Inferentia instances
  enable_aws_efa_k8s_device_plugin = true

  # Example to deploy EFA K8s Device Plugin for GPU/Neuron instances
  enable_aws_efa_k8s_device_plugin = true

  # Example to deploy NVIDIA GPU Operator
  enable_nvidia_gpu_operator = true

  # Example to deploy Spark Operator Helm Chart
  enable_spark_opertor = true

  # Example to deploy Flink Operator Helm Chart
  enable_flink_operator = true

  # Example to deploy Apache YuniKorn Helm Chart
  enable_yunikorn = true

  # Example that uses ECR authentication for a particular registry ID
  enable_emr_spark_operator = var.enable_emr_spark_operator
  emr_spark_operator_helm_config = {
    repository_username = data.aws_ecr_authorization_token.token.user_name
    repository_password = data.aws_ecr_authorization_token.token.password
  }

  # Example to deploy Helm chart that uses IAM Role for ServiceAccounts. You can disable `create_irsa` and bring your own IAM role.
  enable_spark_history_server = var.enable_emr_spark_operator
  spark_history_server_helm_config = {
    create_irsa = true
    values = [
      templatefile("${path.module}/test/helm-values/spark-history-server-values.yaml", {
        s3_bucket_name   = module.s3_bucket.s3_bucket_id
        s3_bucket_prefix = aws_s3_object.this.key
      })
    ]
  }
}

