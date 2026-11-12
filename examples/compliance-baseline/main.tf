provider "aws" {
  region = local.region
}

data "aws_availability_zones" "available" {
  # Exclude local zones
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_caller_identity" "current" {}

data "aws_partition" "current" {}

locals {
  name   = "ex-${basename(path.cwd)}"
  region = "eu-west-1"

  vpc_cidr = "10.0.0.0/16"
  azs      = slice(data.aws_availability_zones.available.names, 0, 3)

  # Use the caller-supplied CMK when provided, otherwise the one created below
  kms_key_arn = var.kms_key_arn != "" ? var.kms_key_arn : aws_kms_key.aurora.arn

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-rds-aurora"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# Customer-managed KMS key (encryption at rest, PI, logs, activity stream)
################################################################################

# The CMK encrypts storage, Performance Insights, the activity stream, and the
# CloudWatch log group. CloudWatch Logs will only write to a CMK-encrypted log
# group when the key policy grants the logs service principal use of the key,
# scoped to the target log group ARN.
data "aws_iam_policy_document" "kms" {
  # Full administration of the key by the account root
  statement {
    sid       = "EnableRootAccountAdmin"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }

  # Allow CloudWatch Logs to use the key for the cluster's log group
  statement {
    sid = "AllowCloudWatchLogs"
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*",
    ]
    resources = ["*"]

    principals {
      type        = "Service"
      identifiers = ["logs.${local.region}.amazonaws.com"]
    }

    condition {
      test     = "ArnLike"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values   = ["arn:${data.aws_partition.current.partition}:logs:${local.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/rds/cluster/${local.name}/*"]
    }
  }
}

resource "aws_kms_key" "aurora" {
  description             = "CMK for ${local.name} Aurora compliance baseline"
  deletion_window_in_days = 7
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms.json

  tags = local.tags
}

resource "aws_kms_alias" "aurora" {
  name          = "alias/${local.name}"
  target_key_id = aws_kms_key.aurora.key_id
}

################################################################################
# RDS Aurora Module - audit-ready baseline
################################################################################

module "aurora" {
  source = "../../"

  name           = local.name
  engine         = "aurora-postgresql"
  engine_version = "17.5"

  # Encryption at rest with a customer-managed key
  storage_encrypted = true
  kms_key_id        = local.kms_key_arn

  # At least one instance, or the module creates an empty cluster with no writer
  instances = {
    writer = {
      instance_class                  = "db.r6g.large"
      promotion_tier                  = 0
      performance_insights_enabled    = true
      performance_insights_kms_key_id = local.kms_key_arn
      monitoring_interval             = 30
    }
  }

  # Credentials in Secrets Manager with managed rotation
  master_username                                        = "root"
  manage_master_user_password                            = true
  manage_master_user_password_rotation                   = true
  master_user_password_rotation_automatically_after_days = var.master_user_password_rotation_days

  # IAM database authentication and deletion protection
  iam_database_authentication_enabled = true
  deletion_protection                 = true

  # Example clusters are disposable: skip the final snapshot so `terraform
  # destroy` does not require a final_snapshot_identifier
  skip_final_snapshot = true

  # Encrypted audit log export to CloudWatch
  enabled_cloudwatch_logs_exports = ["postgresql"]
  create_cloudwatch_log_group     = true
  cloudwatch_log_group_kms_key_id = local.kms_key_arn

  # Cluster-level Performance Insights with the CMK
  cluster_performance_insights_enabled    = true
  cluster_performance_insights_kms_key_id = local.kms_key_arn

  # Database Activity Streams
  cluster_activity_stream = {
    mode                 = var.activity_stream_mode
    kms_key_id           = local.kms_key_arn
    include_audit_fields = true
  }

  # pgAudit and connection logging via the cluster parameter group
  cluster_parameter_group = {
    name        = local.name
    family      = "aurora-postgresql17"
    description = "${local.name} compliance baseline cluster parameter group"
    parameters = [
      {
        name         = "shared_preload_libraries"
        value        = "pgaudit"
        apply_method = "pending-reboot"
      },
      {
        name         = "pgaudit.log"
        value        = var.pgaudit_log_classes
        apply_method = "immediate"
      },
      {
        name         = "log_connections"
        value        = 1
        apply_method = "immediate"
      },
      {
        name         = "log_disconnections"
        value        = 1
        apply_method = "immediate"
      },
      {
        name         = "rds.force_ssl"
        value        = 1
        apply_method = "pending-reboot"
      }
    ]
  }

  # Network isolation: private (database) subnets only, ingress from VPC private CIDRs
  vpc_id               = module.vpc.vpc_id
  db_subnet_group_name = module.vpc.database_subnet_group_name
  security_group_ingress_rules = {
    private-az1 = { cidr_ipv4 = element(module.vpc.private_subnets_cidr_blocks, 0) }
    private-az2 = { cidr_ipv4 = element(module.vpc.private_subnets_cidr_blocks, 1) }
    private-az3 = { cidr_ipv4 = element(module.vpc.private_subnets_cidr_blocks, 2) }
  }

  apply_immediately = true

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = local.name
  cidr = local.vpc_cidr

  azs = local.azs
  # No public subnets: this baseline keeps the database network-isolated
  private_subnets  = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k)]
  database_subnets = [for k, v in local.azs : cidrsubnet(local.vpc_cidr, 8, k + 3)]

  create_database_subnet_group = true

  tags = local.tags
}
