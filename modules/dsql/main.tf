################################################################################
# Cluster
################################################################################

resource "aws_dsql_cluster" "this" {
  count = var.create ? 1 : 0

  region = var.region

  deletion_protection_enabled = var.deletion_protection_enabled
  kms_encryption_key          = var.kms_encryption_key
  force_destroy               = var.force_destroy

  dynamic "multi_region_properties" {
    for_each = var.witness_region != null ? [true] : []

    content {
      witness_region = var.witness_region
    }
  }

  tags = merge(
    var.tags,
    { for k, v in { Name = var.name } : k => v if v != "" }
  )
}

################################################################################
# Cluster Peering
################################################################################

resource "aws_dsql_cluster_peering" "this" {
  count = var.create && var.create_cluster_peering ? 1 : 0

  region = var.region

  clusters       = var.clusters
  identifier     = aws_dsql_cluster.this[0].identifier
  witness_region = var.witness_region

  dynamic "timeouts" {
    for_each = var.timeouts != null ? [var.timeouts] : []

    content {
      create = timeouts.value.create
    }
  }
}

################################################################################
# Cluster Policy
################################################################################

resource "aws_dsql_cluster_policy" "this" {
  count = var.create && var.create_cluster_policy ? 1 : 0

  region = var.region

  identifier                         = aws_dsql_cluster.this[0].identifier
  policy                             = local.create_policy_document ? data.aws_iam_policy_document.dsql_policy[0].json : var.cluster_policy
  bypass_policy_lockout_safety_check = var.cluster_policy_bypass_lockout_safety_check

  dynamic "timeouts" {
    for_each = var.cluster_policy_timeouts != null ? [var.cluster_policy_timeouts] : []

    content {
      create = timeouts.value.create
      update = timeouts.value.update
      delete = timeouts.value.delete
    }
  }
}

################################################################################
# Cluster Policy Document
################################################################################

locals {
  create_policy_document = var.create && var.create_cluster_policy && (length(var.cluster_policy_statements) > 0 || length(var.cluster_policy_source_policy_documents) > 0 || length(var.cluster_policy_override_policy_documents) > 0)
}

data "aws_iam_policy_document" "dsql_policy" {
  count = local.create_policy_document ? 1 : 0

  source_policy_documents   = var.cluster_policy_source_policy_documents
  override_policy_documents = var.cluster_policy_override_policy_documents

  dynamic "statement" {
    for_each = var.cluster_policy_statements

    content {
      sid       = statement.value.sid
      actions   = statement.value.actions
      effect    = statement.value.effect
      resources = statement.value.resources

      dynamic "principals" {
        for_each = statement.value.principals != null ? statement.value.principals : []

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = statement.value.conditions != null ? statement.value.conditions : []

        content {
          test     = condition.value.test
          values   = condition.value.values
          variable = condition.value.variable
        }
      }
    }
  }
}
