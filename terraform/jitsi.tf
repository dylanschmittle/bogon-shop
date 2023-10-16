module "eks_blueprints_addon_jitsi" {
  source  = "aws-ia/eks-blueprints-addon/aws"
  version = "~> 1.0" #ensure to update this to the latest/desired version

  chart         = "jitsi"
  chart_version = "1.3.7"
  repository    = "https://jitsi-contrib.github.io/jitsi-helm/"
  description   = "Jitsi server helm Chart deployment configuration"
  namespace     = "jitsi"

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
