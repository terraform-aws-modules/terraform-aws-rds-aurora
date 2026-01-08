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
