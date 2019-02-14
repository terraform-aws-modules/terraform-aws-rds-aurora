locals {
  iam_authentication_enabled_mysql_versions = {
    "8.0.11" = false
    "5.7.23" = true
    "5.7.22" = true
    "5.7.21" = true
    "5.7.19" = true
    "5.7.17" = true
    "5.7.16" = true
    "5.6.41" = true
    "5.6.40" = true
    "5.6.39" = true
    "5.6.37" = true
    "5.6.35" = true
    "5.6.34" = true
    "5.5.61" = false
    "5.5.59" = false
    "5.5.57" = false
    "5.5.54" = false
    "5.5.53" = false
    "5.5.46" = false
  }

  iam_authentication_enabled_postgresql_versions = {
    "10.6"   = true
    "10.5"   = false
    "10.4"   = false
    "10.3"   = false
    "10.1"   = false
    "9.6.11" = true
    "9.6.10" = false
    "9.6.9"  = false
    "9.6.8"  = false
    "9.6.6"  = false
    "9.6.5"  = false
    "9.6.3"  = false
    "9.6.2"  = false
    "9.6.1"  = false
    "9.5.15" = true
    "9.5.13" = false
    "9.5.12" = false
    "9.5.10" = false
    "9.5.9"  = false
    "9.5.7"  = false
    "9.5.6"  = false
    "9.5.4"  = false
    "9.5.2"  = false
    "9.4.20" = false
    "9.4.19" = false
    "9.4.18" = false
    "9.4.17" = false
    "9.4.15" = false
    "9.4.14" = false
    "9.4.12" = false
    "9.4.11" = false
    "9.4.9"  = false
    "9.4.7"  = false
    "9.3.25" = false
    "9.3.24" = false
    "9.3.23" = false
    "9.3.22" = false
    "9.3.20" = false
    "9.3.19" = false
    "9.3.17" = false
    "9.3.16" = false
    "9.3.14" = false
    "9.3.12" = false
  }

  iam_unsupported_instance_types = [
    "db.t2.small",
    "db.m1.small",
  ]

  iam_supported_mysql_version = "${var.engine == "aurora-mysql" && !contains(local.iam_unsupported_instance_types, var.instance_type) ? lookup(local.iam_authentication_enabled_mysql_versions, var.engine_version, false) : false}"

  iam_supported_postgresql_version = "${var.engine == "aurora-postgresql" && !contains(local.iam_unsupported_instance_types, var.instance_type) ? lookup(local.iam_authentication_enabled_postgresql_versions, var.engine_version, false) : false}"

  iam_database_authentication_enabled = "${local.iam_supported_mysql_version || local.iam_supported_postgresql_version ? var.iam_database_authentication_enabled : false}"
}
