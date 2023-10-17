# AWS managed policy for CSI driver SA to make EBS API calls
POLICY_ARN="arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"

# AWS IAM role bound to a Kubernetes service account
eksctl create iamserviceaccount \
  --name "ebs-csi-controller-sa" \
  --namespace "kube-system" \
  --cluster eg-test-eks-cluster \
  --region us-east-2 \
  --attach-policy-arn $POLICY_ARN \
  --role-only \
  --role-name AmazonEBSCSIDriverPolicy \
  --approve


eksctl create addon \
  --name "aws-ebs-csi-driver" \
  --cluster eg-test-eks-cluster \
  --region us-east-2 \
  --service-account-role-arn $ACCOUNT_ROLE_ARN \
  --force


