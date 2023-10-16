module "eks_blueprints_addon_gitea" {
  source  = "aws-ia/eks-blueprints-addon/aws"
  version = "~> 1.0" #ensure to update this to the latest/desired version

  chart         = "gitea"
  chart_version = "1.20.5"
  repository    = "https://gitea.com/gitea/helm-chart"
  description   = "Gitea server helm Chart deployment configuration"
  namespace     = "gitea"

  values = [
    <<-EOT
      podDisruptionBudget:
        maxUnavailable: 1
      metrics:
        enabled: false
    EOT
  ]

  set = [
    {
      name  = "replicas"
      value = 1
    }
  ]
}
