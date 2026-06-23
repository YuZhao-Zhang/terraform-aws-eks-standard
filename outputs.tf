output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks.cluster_name
}

output "cluster_arn" {
  description = "ARN of the EKS cluster"
  value       = module.eks.cluster_arn
}

output "cluster_endpoint" {
  description = "API server endpoint for the EKS cluster"
  value       = module.eks.cluster_endpoint
}

output "cluster_version" {
  description = "Kubernetes version configured by the wrapper module"
  value       = module.eks.cluster_version
}

output "oidc_provider_arn" {
  description = "ARN of the OIDC provider created for IRSA"
  value       = module.eks.oidc_provider_arn
}

output "node_group_name" {
  description = "Name of the managed node group created by the wrapper"
  value       = module.eks.eks_managed_node_groups["default"].node_group_name
}