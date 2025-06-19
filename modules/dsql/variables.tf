variable "create" {
  description = "Whether cluster should be created (affects all resources)"
  type        = bool
  default     = true
}

variable "deletion_protection_enabled" {
  description = "Whether deletion protection is enabled in this cluster"
  type        = bool
  default     = null
}

variable "kms_encryption_key" {
  description = "The ARN of the AWS KMS key that encrypts data in the DSQL Cluster, or `AWS_OWNED_KMS_KEY`"
  type        = string
  default     = null
}

variable "create_cluster_peering" {
  description = "Whether to create cluster peering"
  type        = bool
  default     = false
}

variable "clusters" {
  description = "List of DSQL Cluster ARNs to be peered to this cluster"
  type        = list(string)
  default     = null
}

variable "witness_region" {
  description = "Witness region for the multi-region clusters. Setting this makes this cluster a multi-region cluster. Changing it recreates the cluster"
  type        = string
  default     = null
}

variable "timeouts" {
  description = "Create timeout configuration for the cluster"
  type        = any
  default     = {}
}

variable "tags" {
  description = "A map of tags to be associated with the AWS DSQL Cluster resource"
  type        = map(string)
  default     = {}
}
