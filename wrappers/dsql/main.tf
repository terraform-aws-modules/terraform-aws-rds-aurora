module "wrapper" {
  source = "../../modules/dsql"

  for_each = var.items

  clusters                    = try(each.value.clusters, var.defaults.clusters, null)
  create                      = try(each.value.create, var.defaults.create, true)
  create_cluster_peering      = try(each.value.create_cluster_peering, var.defaults.create_cluster_peering, false)
  deletion_protection_enabled = try(each.value.deletion_protection_enabled, var.defaults.deletion_protection_enabled, null)
  force_destroy               = try(each.value.force_destroy, var.defaults.force_destroy, null)
  kms_encryption_key          = try(each.value.kms_encryption_key, var.defaults.kms_encryption_key, null)
  name                        = try(each.value.name, var.defaults.name, "")
  region                      = try(each.value.region, var.defaults.region, null)
  tags                        = try(each.value.tags, var.defaults.tags, {})
  timeouts                    = try(each.value.timeouts, var.defaults.timeouts, null)
  witness_region              = try(each.value.witness_region, var.defaults.witness_region, null)
}
