# terraform-aws-eks-standard

This module is a thin wrapper around `terraform-aws-modules/eks/aws` that intentionally exposes only a small, stable input surface for HCP Terraform No-Code usage.

Architecture:

```text
No-Code User
     ↓
HCP Terraform No-Code Module
     ↓
This Wrapper Module
     ↓
terraform-aws-modules/eks/aws
```

## Exposed Inputs

Only these inputs are part of the wrapper contract:

- `cluster_name`
- `environment`
- `region`
- `vpc_id`
- `private_subnet_ids`
- `node_instance_type`
- `node_count`

## Hardcoded Decisions

This wrapper deliberately does not expose the upstream module directly. It hardcodes the following:

- Upstream module version: `21.23.0`
- Kubernetes version: `1.33`
- Compute model: one EKS managed node group named `default`
- Node group scaling: fixed size where `min_size`, `max_size`, and `desired_size` all equal `node_count`
- IRSA: enabled
- Authentication mode: `API_AND_CONFIG_MAP`
- Cluster creator admin permissions: enabled
- Endpoint access: public enabled
- Add-ons: `coredns`, `eks-pod-identity-agent`, `kube-proxy`, `vpc-cni`
- Control plane subnets: same as `private_subnet_ids`

Not exposed by design:

- self-managed node groups
- Fargate profiles
- Karpenter
- custom security group tuning
- custom access entries
- custom add-on configuration
- custom Kubernetes version selection

## Example

```hcl
module "eks_standard" {
  source = "./"

  cluster_name      = "example-cluster"
  environment       = "dev"
  region            = "us-west-2"
  vpc_id            = "vpc-0123456789abcdef0"
  private_subnet_ids = [
    "subnet-0123456789abcdef0",
    "subnet-11111111111111111",
    "subnet-22222222222222222",
  ]
  node_instance_type = "m6i.large"
  node_count         = 2
}
```