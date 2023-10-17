module "helm_release" {
  source  = "cloudposse/helm-release/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"

  name = "echo"

  repository    = "https://charts.helm.sh/incubator"
  chart         = "raw"
  chart_version = "0.2.5"

  create_namespace     = true
  kubernetes_namespace = "echo"

  atomic          = true
  cleanup_on_fail = true
  timeout         = 300
  wait            = true

  # These values will be deep merged
  # values = [
  # ]

  # Enable the IAM role
  iam_role_enabled = true

  # Add the IAM role using set()
  service_account_role_arn_annotation_enabled = true

  # Dictates which ServiceAccounts are allowed to assume the IAM Role.
  # In this case, only the "echo" ServiceAccount in the "echo" namespace
  # will be able to assume the IAM Role created by this module.
  service_account_name      = "echo"
  service_account_namespace = "echo"

  # IAM policy statements to add to the IAM role
  iam_policy = [{
    statements = [{
      sid        = "ListMyBucket"
      effect     = "Allow"
      actions    = ["s3:ListBucket"]
      resources  = ["arn:aws:s3:::test"]
      conditions = []
    },
    {
      sid        = "WriteMyBucket"
      effect     = "Allow"
      actions    = ["s3:PutObject", "s3:GetObject", "s3:DeleteObject"]
      resources  = ["arn:aws:s3:::test/*"]
      conditions = []
    }]
  }]
}
