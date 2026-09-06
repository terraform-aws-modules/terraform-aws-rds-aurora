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
  policy                             = var.cluster_policy != null ? var.cluster_policy : data.aws_iam_policy_document.dsql_policy[0].json
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
# IAM Policy Document
################################################################################

data "aws_iam_policy_document" "dsql_policy" {
  count = var.create && var.create_iam_policy ? 1 : 0

  dynamic "statement" {
    for_each = var.iam_policy_statements

    content {
      sid       = statement.value.sid
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources

      dynamic "principals" {
        for_each = statement.value.principals

        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = statement.value.conditions

        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}
