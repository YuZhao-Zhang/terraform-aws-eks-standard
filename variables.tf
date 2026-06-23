variable "cluster_name" {
  description = "Name of the EKS cluster to create"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.cluster_name)) > 0
    error_message = "cluster_name must not be empty."
  }
}

variable "environment" {
  description = "Environment name used for tagging"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.environment)) > 0
    error_message = "environment must not be empty."
  }
}

variable "region" {
  description = "AWS region passed through to the upstream EKS module"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.region)) > 0
    error_message = "region must not be empty."
  }
}

variable "vpc_id" {
  description = "ID of the VPC where the EKS cluster will run"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.vpc_id)) > 0
    error_message = "vpc_id must not be empty."
  }
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for the EKS control plane and worker nodes"
  type        = list(string)
  nullable    = false

  validation {
    condition     = length(var.private_subnet_ids) > 0
    error_message = "private_subnet_ids must contain at least one subnet ID."
  }
}

variable "node_instance_type" {
  description = "EC2 instance type for the managed node group"
  type        = string
  nullable    = false

  validation {
    condition     = length(trimspace(var.node_instance_type)) > 0
    error_message = "node_instance_type must not be empty."
  }
}

variable "node_count" {
  description = "Fixed node count for the managed node group"
  type        = number
  nullable    = false

  validation {
    condition     = var.node_count >= 1 && floor(var.node_count) == var.node_count
    error_message = "node_count must be a whole number greater than or equal to 1."
  }
}