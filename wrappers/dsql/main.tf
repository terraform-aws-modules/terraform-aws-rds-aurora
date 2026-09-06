module "wrapper" {
  source = "../../modules/dsql"

  for_each = var.items

  cluster_policy                             = try(each.value.cluster_policy, var.defaults.cluster_policy, null)
  cluster_policy_bypass_lockout_safety_check = try(each.value.cluster_policy_bypass_lockout_safety_check, var.defaults.cluster_policy_bypass_lockout_safety_check, null)
  cluster_policy_timeouts                    = try(each.value.cluster_policy_timeouts, var.defaults.cluster_policy_timeouts, null)
  clusters                                   = try(each.value.clusters, var.defaults.clusters, null)
  create                                     = try(each.value.create, var.defaults.create, true)
  create_cluster_peering                     = try(each.value.create_cluster_peering, var.defaults.create_cluster_peering, false)
  create_cluster_policy                      = try(each.value.create_cluster_policy, var.defaults.create_cluster_policy, false)
  create_iam_policy                          = try(each.value.create_iam_policy, var.defaults.create_iam_policy, true)
  deletion_protection_enabled                = try(each.value.deletion_protection_enabled, var.defaults.deletion_protection_enabled, null)
  force_destroy                              = try(each.value.force_destroy, var.defaults.force_destroy, null)
  iam_policy_statements                      = try(each.value.iam_policy_statements, var.defaults.iam_policy_statements, [])
  kms_encryption_key                         = try(each.value.kms_encryption_key, var.defaults.kms_encryption_key, null)
  name                                       = try(each.value.name, var.defaults.name, "")
  region                                     = try(each.value.region, var.defaults.region, null)
  tags                                       = try(each.value.tags, var.defaults.tags, {})
  timeouts                                   = try(each.value.timeouts, var.defaults.timeouts, null)
  witness_region                             = try(each.value.witness_region, var.defaults.witness_region, null)
}
