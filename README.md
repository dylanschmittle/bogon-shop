[Terraform Cloud](https://app.terraform.io/app/bogon-shop/workspaces/bogon-shop/)

[AWS EKS](https://us-east-2.console.aws.amazon.com/eks/home?region=us-east-2#/clusters)


## Things that are not in the terraform yet

### EBS CSI Driver

arn:aws:iam::754977136847:role/AmazonEKS_EBS_CSI_DriverRole

### Metrics Server

https://artifacthub.io/packages/helm/metrics-server/metrics-server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml


.
├── LICENSE
├── README.md
├── manifests
│   └── gp3.yaml
├── terraform
│   ├── README.md
│   ├── context.tf
│   ├── fixtures.auto.tfvars
│   ├── jitsi-helm.tf
│   ├── jitsi-values.yaml
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── values.yaml
│   ├── variables.tf
│   └── versions.tf
└── terraform-off
    ├── gitea-helm.tf
    └── gitea-values.yaml

4 directories, 16 files
