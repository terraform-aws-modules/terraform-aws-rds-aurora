variable "create" {
  description = "Whether cluster should be created (affects all resources)"
  type        = bool
  default     = true
}

variable "region" {
  description = "Region where the resource(s) will be managed. Defaults to the Region set in the provider configuration"
  type        = string
  default     = null
}

variable "name" {
  description = "Name used across resources created"
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

################################################################################
# Cluster
################################################################################

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

variable "force_destroy" {
  description = "Destroys cluster even if deletion_protection_enabled is set to true. Default value is false"
  type        = bool
  default     = null
}

################################################################################
# Cluster Peering
################################################################################

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
  description = "Timeout configuration for the cluster"
  type = object({
    create = optional(string)
  })
  default = null
}

################################################################################
# Cluster Policy
################################################################################

variable "create_cluster_policy" {
  description = "Whether to create the DSQL cluster resource-based policy"
  type        = bool
  default     = false
}

variable "cluster_policy" {
  description = "The Aurora DSQL cluster resource-based policy document as a JSON string. Ignored if cluster_policy_statements, cluster_policy_source_policy_documents, or cluster_policy_override_policy_documents are set."
  type        = string
  default     = null
}

variable "cluster_policy_statements" {
  description = "List of IAM policy statement objects to include in the DSQL cluster resource-based policy. Each statement should have: sid, actions, effect, principals, not_principals, resources, conditions."
  type = list(object({
    sid       = optional(string)
    effect    = optional(string)
    actions   = optional(list(string))
    resources = optional(list(string))
    principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })))
    conditions = optional(list(object({
      test     = string
      variable = string
      values   = list(string)
    })))
  }))
  default = []
}

variable "cluster_policy_source_policy_documents" {
  description = "List of policy documents to include in the DSQL cluster resource-based policy. Merged with the inline policy."
  type        = list(string)
  default     = []
}

variable "cluster_policy_override_policy_documents" {
  description = "List of policy documents to override the DSQL cluster resource-based policy. These policies completely replace the inline policy."
  type        = list(string)
  default     = []
}

variable "cluster_policy_bypass_lockout_safety_check" {
  description = "Whether to bypass the policy lockout safety check when applying the policy. Use with caution, as the policy may lock you out of the cluster"
  type        = bool
  default     = null
}

variable "cluster_policy_timeouts" {
  description = "Timeout configuration for the DSQL cluster resource-based policy"
  type = object({
    create = optional(string)
    update = optional(string)
    delete = optional(string)
  })
  default = null
}
