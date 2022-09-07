provider "aws" {
  region = local.primary.region
}

provider "aws" {
  alias  = "secondary"
  region = local.secondary.region
}

locals {
  name = "ex-${replace(basename(path.cwd), "_", "-")}"

  primary = {
    region      = "eu-west-1"
    cidr_prefix = "10.99"
  }
  secondary = {
    region      = "us-east-1"
    cidr_prefix = "10.98"
  }

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-rds-aurora"
    GithubOrg  = "terraform-aws-modules"
  }
}

data "aws_caller_identity" "current" {}

################################################################################
# RDS Aurora Module
################################################################################

resource "aws_rds_global_cluster" "this" {
  global_cluster_identifier = local.name
  engine                    = "aurora-postgresql"
  engine_version            = "11.12"
  database_name             = "example_db"
  storage_encrypted         = true
}

module "aurora_primary" {
  source = "../../"

  name                      = local.name
  database_name             = aws_rds_global_cluster.this.database_name
  engine                    = aws_rds_global_cluster.this.engine
  engine_version            = aws_rds_global_cluster.this.engine_version
  global_cluster_identifier = aws_rds_global_cluster.this.id
  instance_class            = "db.r6g.large"
  instances                 = { for i in range(2) : i => {} }
  kms_key_id                = aws_kms_key.primary.arn

  vpc_id                 = module.primary_vpc.vpc_id
  db_subnet_group_name   = module.primary_vpc.database_subnet_group_name
  create_db_subnet_group = false
  create_security_group  = true
  allowed_cidr_blocks    = module.primary_vpc.private_subnets_cidr_blocks

  skip_final_snapshot = true

  tags = local.tags
}

module "aurora_secondary" {
  source = "../../"

  providers = { aws = aws.secondary }

  is_primary_cluster = false

  name                      = local.name
  engine                    = aws_rds_global_cluster.this.engine
  engine_version            = aws_rds_global_cluster.this.engine_version
  global_cluster_identifier = aws_rds_global_cluster.this.id
  source_region             = local.primary.region
  instance_class            = "db.r6g.large"
  instances                 = { for i in range(2) : i => {} }
  kms_key_id                = aws_kms_key.secondary.arn

  vpc_id                 = module.secondary_vpc.vpc_id
  db_subnet_group_name   = module.secondary_vpc.database_subnet_group_name
  create_db_subnet_group = false
  create_security_group  = true
  allowed_cidr_blocks    = module.secondary_vpc.private_subnets_cidr_blocks

  skip_final_snapshot = true

  depends_on = [
    module.aurora_primary
  ]

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

module "primary_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  name = local.name
  cidr = "${local.primary.cidr_prefix}.0.0/18"

  azs              = ["${local.primary.region}a", "${local.primary.region}b", "${local.primary.region}c"]
  public_subnets   = ["${local.primary.cidr_prefix}.0.0/24", "${local.primary.cidr_prefix}.1.0/24", "${local.primary.cidr_prefix}.2.0/24"]
  private_subnets  = ["${local.primary.cidr_prefix}.3.0/24", "${local.primary.cidr_prefix}.4.0/24", "${local.primary.cidr_prefix}.5.0/24"]
  database_subnets = ["${local.primary.cidr_prefix}.7.0/24", "${local.primary.cidr_prefix}.8.0/24", "${local.primary.cidr_prefix}.9.0/24"]

  tags = local.tags
}

module "secondary_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 3.0"

  providers = { aws = aws.secondary }

  name = local.name
  cidr = "${local.secondary.cidr_prefix}.0.0/18"

  azs              = ["${local.secondary.region}a", "${local.secondary.region}b", "${local.secondary.region}c"]
  public_subnets   = ["${local.secondary.cidr_prefix}.0.0/24", "${local.secondary.cidr_prefix}.1.0/24", "${local.secondary.cidr_prefix}.2.0/24"]
  private_subnets  = ["${local.secondary.cidr_prefix}.3.0/24", "${local.secondary.cidr_prefix}.4.0/24", "${local.secondary.cidr_prefix}.5.0/24"]
  database_subnets = ["${local.secondary.cidr_prefix}.7.0/24", "${local.secondary.cidr_prefix}.8.0/24", "${local.secondary.cidr_prefix}.9.0/24"]

  tags = local.tags
}

data "aws_iam_policy_document" "rds" {
  statement {
    sid       = "Enable IAM User Permissions"
    actions   = ["kms:*"]
    resources = ["*"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root",
        data.aws_caller_identity.current.arn,
      ]
    }
  }

  statement {
    sid = "Allow use of the key"
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]

    principals {
      type = "Service"
      identifiers = [
        "monitoring.rds.amazonaws.com",
        "rds.amazonaws.com",
      ]
    }
  }
}

resource "aws_kms_key" "primary" {
  policy = data.aws_iam_policy_document.rds.json
  tags   = local.tags
}

resource "aws_kms_key" "secondary" {
  provider = aws.secondary

  policy = data.aws_iam_policy_document.rds.json
  tags   = local.tags
}
