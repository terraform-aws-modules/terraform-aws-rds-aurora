resource "aws_ssm_parameter" "master_password" {
  count       = var.store_master_password_to_ssm && local.use_master_password && local.create ? 1 : 0
  name        = coalesce(var.master_password_ssm_param_name, "rds/${var.name}")
  description = "Master password of ${aws_rds_cluster.this[0].id}"
  type        = "SecureString"
  value_wo = jsonencode({
    master_username = var.master_username,
    password        = ephemeral.random_password.password.result
  })
  value_wo_version = time_static.password[0].unix
  key_id           = var.master_password_secret_kms_key_id
}
