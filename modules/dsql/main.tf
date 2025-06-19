resource "aws_dsql_cluster" "this" {
  count = var.create ? 1 : 0

  deletion_protection_enabled = var.deletion_protection_enabled
  kms_encryption_key          = var.kms_encryption_key

  dynamic "multi_region_properties" {
    for_each = var.witness_region != null ? [true] : []
    content {
      witness_region = var.witness_region
    }
  }

  tags = var.tags
}

resource "aws_dsql_cluster_peering" "this" {
  count = var.create && var.create_cluster_peering ? 1 : 0

  clusters       = var.clusters
  identifier     = aws_dsql_cluster.this[0].identifier
  witness_region = var.witness_region

  timeouts {
    create = try(var.timeouts.create, null)
  }
}
