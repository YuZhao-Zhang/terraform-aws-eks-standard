locals {
  kubernetes_version = "1.33"

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "terraform-aws-eks-standard"
  }
}

provider "aws" {
  region = var.region
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.23.0"

  name               = var.cluster_name
  kubernetes_version = local.kubernetes_version
  region             = var.region

  vpc_id                   = var.vpc_id
  subnet_ids               = var.private_subnet_ids
  control_plane_subnet_ids = var.private_subnet_ids

  endpoint_public_access                   = true
  enable_cluster_creator_admin_permissions = true
  authentication_mode                      = "API_AND_CONFIG_MAP"
  enable_irsa                              = true

  addons = {
    coredns = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy = {}
    vpc-cni = {
      before_compute = true
    }
  }

  eks_managed_node_groups = {
    default = {
      name = "${var.cluster_name}-${var.environment}"

      instance_types = [var.node_instance_type]

      min_size     = var.node_count
      max_size     = var.node_count
      desired_size = var.node_count
    }
  }

  tags = local.tags
}