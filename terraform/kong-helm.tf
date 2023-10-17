module "kong" {
  source = "cloudposse/helm-release/aws"
  version = "0.10.1"

  name = "kong"

  repository    = "https://charts.konghq.com"
  chart         = "kong"
  chart_version = "0.7.0"

  create_namespace     = true
  kubernetes_namespace = "kong"

  atomic          = true
  cleanup_on_fail = true
  timeout         = 300
  wait            = true

  # These values will be deep merged
  values = [
    file("${path.module}/kong-values.yaml")
  ]

  # Enable the IAM role
  iam_role_enabled            = true
  
  eks_cluster_oidc_issuer_url = module.eks_cluster.eks_cluster_identity_oidc_issuer
  
  # Add the IAM role using set()
  service_account_role_arn_annotation_enabled = true

  # Dictates which ServiceAccounts are allowed to assume the IAM Role.
  # In this case, only the "kong" ServiceAccount in the "kong" namespace
  # will be able to assume the IAM Role created by this module.
  service_account_name      = "kong"
  service_account_namespace = "kong"

  # IAM policy statements to add to the IAM role
  iam_policy = [{
    statements = [{
      sid        = "ListMyBucket"
      effect     = "Allow"
      actions    = ["s3:ListBucket"]
      resources  = ["arn:aws:s3:::kong"]
      conditions = []
      },
      {
        sid        = "WriteMyBucket"
        effect     = "Allow"
        actions    = ["s3:PutObject", "s3:GetObject", "s3:DeleteObject"]
        resources  = ["arn:aws:s3:::kong/*"]
        conditions = []
    }]
  }]
}
