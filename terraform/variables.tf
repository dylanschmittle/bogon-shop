variable "region" {
  type        = string
  description = "AWS Region"
}

variable "AWS_SECRET_ACCESS_KEY" {
  type = string
}
variable "AWS_ACCESS_KEY_ID" {
  type = string
}
variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones"
}

variable "kubernetes_version" {
  type        = string
  default     = "1.21"
  description = "Desired Kubernetes master version. If you do not specify a value, the latest available version is used"
}

variable "enabled_cluster_log_types" {
  type        = list(string)
  default     = []
  description = "A list of the desired control plane logging to enable. For more information, see https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html. Possible values [`api`, `audit`, `authenticator`, `controllerManager`, `scheduler`]"
}

variable "cluster_log_retention_period" {
  type        = number
  default     = 0
  description = "Number of days to retain cluster logs. Requires `enabled_cluster_log_types` to be set. See https://docs.aws.amazon.com/en_us/eks/latest/userguide/control-plane-logs.html."
}

variable "map_additional_aws_accounts" {
  description = "Additional AWS account numbers to add to `config-map-aws-auth` ConfigMap"
  type        = list(string)
  default     = []
}

variable "map_additional_iam_roles" {
  description = "Additional IAM roles to add to `config-map-aws-auth` ConfigMap"

  type = list(object({
    rolearn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}

variable "map_additional_iam_users" {
  description = "Additional IAM users to add to `config-map-aws-auth` ConfigMap"

  type = list(object({
    userarn  = string
    username = string
    groups   = list(string)
  }))

  default = []
}

variable "oidc_provider_enabled" {
  type        = bool
  default     = true
  description = "Create an IAM OIDC identity provider for the cluster, then you can create IAM roles to associate with a service account in the cluster, instead of using `kiam` or `kube2iam`. For more information, see https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html"
}

variable "local_exec_interpreter" {
  type        = list(string)
  default     = ["/bin/sh", "-c"]
  description = "shell to use for local_exec"
}

variable "instance_types" {
  type        = list(string)
  description = "Set of instance types associated with the EKS Node Group. Defaults to [\"t3.medium\"]. Terraform will only perform drift detection if a configuration value is provided"
}

variable "kubernetes_labels" {
  type        = map(string)
  description = "Key-value mapping of Kubernetes labels. Only labels that are applied with the EKS API are managed by this argument. Other Kubernetes labels applied to the EKS Node Group will not be managed"
  default     = {}
}

variable "desired_size" {
  type        = number
  description = "Desired number of worker nodes"
}

variable "max_size" {
  type        = number
  description = "The maximum size of the AutoScaling Group"
}

variable "min_size" {
  type        = number
  description = "The minimum size of the AutoScaling Group"
}

variable "cluster_encryption_config_enabled" {
  type        = bool
  default     = true
  description = "Set to `true` to enable Cluster Encryption Configuration"
}

variable "cluster_encryption_config_kms_key_id" {
  type        = string
  default     = ""
  description = "KMS Key ID to use for cluster encryption config"
}

variable "cluster_encryption_config_kms_key_enable_key_rotation" {
  type        = bool
  default     = true
  description = "Cluster Encryption Config KMS Key Resource argument - enable kms key rotation"
}

variable "cluster_encryption_config_kms_key_deletion_window_in_days" {
  type        = number
  default     = 10
  description = "Cluster Encryption Config KMS Key Resource argument - key deletion windows in days post destruction"
}

variable "cluster_encryption_config_kms_key_policy" {
  type        = string
  default     = null
  description = "Cluster Encryption Config KMS Key Resource argument - key policy"
}

variable "cluster_encryption_config_resources" {
  type        = list(any)
  default     = ["secrets"]
  description = "Cluster Encryption Config Resources to encrypt, e.g. ['secrets']"
}

variable "addons" {
  type = list(object({
    addon_name                  = string
    addon_version               = string
    resolve_conflicts_on_create = string
    resolve_conflicts_on_update = string
    service_account_role_arn    = string
  }))
  default     = []
  description = "Manages [`aws_eks_addon`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) resources."
}

variable "apply_config_map_aws_auth" {
  type        = bool
  default     = true
  description = "Whether to apply the ConfigMap to allow worker nodes to join the EKS cluster and allow additional users, accounts and roles to acces the cluster"
}

### helm_release

# variable "chart" {
#   type        = string
#   description = "Chart name to be installed. The chart name can be local path, a URL to a chart, or the name of the chart if `repository` is specified. It is also possible to use the `<repository>/<chart>` format here if you are running Terraform on a system that the repository has been added to with `helm repo add` but this is not recommended."
# }
#
# variable "description" {
#   type        = string
#   description = "Release description attribute (visible in the history)."
#   default     = null
# }
#
# variable "devel" {
#   type        = bool
#   description = "Use chart development versions, too. Equivalent to version `>0.0.0-0`. If version is set, this is ignored."
#   default     = null
# }
#
# variable "repository" {
#   type        = string
#   description = "Repository URL where to locate the requested chart."
#   default     = null
# }
#
# variable "repository_ca_file" {
#   type        = string
#   description = "The Repositories CA file."
#   default     = null
# }
#
# variable "repository_cert_file" {
#   type        = string
#   description = "The repositories cert file."
#   default     = null
# }
#
# variable "repository_key_file" {
#   type        = string
#   description = "The repositories cert key file."
#   default     = null
# }
#
# variable "repository_password" {
#   type        = string
#   description = "Password for HTTP basic authentication against the repository."
#   default     = null
# }
#
# variable "repository_username" {
#   type        = string
#   description = "Username for HTTP basic authentication against the repository."
#   default     = null
# }
#
# variable "chart_version" {
#   type        = string
#   description = "Specify the exact chart version to install. If this is not specified, the latest version is installed."
#   default     = null
# }
#
# variable "create_namespace" {
#   type        = bool
#   description = "Create the namespace if it does not yet exist. Defaults to `false`."
#   default     = null
# }
#
# variable "kubernetes_namespace" {
#   type        = string
#   description = "The namespace to install the release into. Defaults to `default`."
#   default     = null
# }
#
# variable "atomic" {
#   type        = bool
#   description = "If set, installation process purges chart on fail. The wait flag will be set automatically if atomic is used. Defaults to `false`."
#   default     = null
# }
#
# variable "cleanup_on_fail" {
#   type        = bool
#   description = "Allow deletion of new resources created in this upgrade when upgrade fails. Defaults to `false`."
#   default     = null
# }
#
# variable "dependency_update" {
#   type        = bool
#   description = "Runs helm dependency update before installing the chart. Defaults to `false`."
#   default     = null
# }
#
# variable "disable_openapi_validation" {
#   type        = bool
#   description = "If set, the installation process will not validate rendered templates against the Kubernetes OpenAPI Schema. Defaults to `false`."
#   default     = null
# }
#
# variable "disable_webhooks" {
#   type        = bool
#   description = "Prevent hooks from running. Defaults to `false`."
#   default     = null
# }
#
# variable "force_update" {
#   type        = bool
#   description = "Force resource update through delete/recreate if needed. Defaults to `false`."
#   default     = null
# }
#
# variable "keyring" {
#   type        = string
#   description = "Location of public keys used for verification. Used only if `verify` is true. Defaults to `/.gnupg/pubring.gpg` in the location set by `home`."
#   default     = null
# }
#
# variable "lint" {
#   type        = bool
#   description = "Run the helm chart linter during the plan. Defaults to `false`."
#   default     = null
# }
#
# variable "max_history" {
#   type        = number
#   description = "Maximum number of release versions stored per release. Defaults to `0` (no limit)."
#   default     = null
# }
#
# variable "recreate_pods" {
#   type        = bool
#   description = "Perform pods restart during upgrade/rollback. Defaults to `false`."
#   default     = null
# }
#
# variable "render_subchart_notes" {
#   type        = bool
#   description = "If set, render subchart notes along with the parent. Defaults to `true`."
#   default     = null
# }
#
# variable "replace" {
#   type        = bool
#   description = "Re-use the given name, even if that name is already used. This is unsafe in production. Defaults to `false`."
#   default     = null
# }
#
# variable "reset_values" {
#   type        = bool
#   description = "When upgrading, reset the values to the ones built into the chart. Defaults to `false`."
#   default     = null
# }
#
# variable "reuse_values" {
#   type        = bool
#   description = "When upgrading, reuse the last release's values and merge in any overrides. If `reset_values` is specified, this is ignored. Defaults to `false`."
#   default     = null
# }
#
# variable "skip_crds" {
#   type        = bool
#   description = "If set, no CRDs will be installed. By default, CRDs are installed if not already present. Defaults to `false`."
#   default     = null
# }
#
# variable "timeout" {
#   type        = number
#   description = "Time in seconds to wait for any individual kubernetes operation (like Jobs for hooks). Defaults to `300` seconds."
#   default     = null
# }
#
# variable "values" {
#   type        = any
#   description = "List of values in raw yaml to pass to helm. Values will be merged, in order, as Helm does with multiple `-f` options."
#   default     = null
# }
#
# variable "verify" {
#   type        = bool
#   description = "Verify the package before installing it. Helm uses a provenance file to verify the integrity of the chart; this must be hosted alongside the chart. For more information see the Helm Documentation. Defaults to `false`."
#   default     = null
# }
#
# variable "wait" {
#   type        = bool
#   description = "Will wait until all resources are in a ready state before marking the release as successful. It will wait for as long as `timeout`. Defaults to `true`."
#   default     = null
# }
#
# variable "wait_for_jobs" {
#   type        = bool
#   description = "If wait is enabled, will wait until all Jobs have been completed before marking the release as successful. It will wait for as long as `timeout`. Defaults to `false`."
#   default     = null
# }
#
# variable "set" {
#   type = list(object({
#     name  = string
#     value = string
#     type  = string
#   }))
#   description = "Value block with custom values to be merged with the values yaml."
#   default     = []
# }
#
# variable "set_sensitive" {
#   type = list(object({
#     name  = string
#     value = string
#     type  = string
#   }))
#   description = "Value block with custom sensitive values to be merged with the values yaml that won't be exposed in the plan's diff."
#   default     = []
# }
#
# variable "postrender_binary_path" {
#   type        = string
#   description = "Relative or full path to command binary."
#   default     = null
# }
#
