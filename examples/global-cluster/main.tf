provider "aws" {
  region = local.primary_region
}

data "aws_caller_identity" "current" {}

data "aws_availability_zones" "primary" {
  region = local.primary_region

  # Exclude local zones
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

data "aws_availability_zones" "secondary" {
  region = local.secondary_region

  # Exclude local zones
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

locals {
  name = "ex-${basename(path.cwd)}"

  primary_region   = "eu-west-1"
  primary_vpc_cidr = "10.0.0.0/16"
  primary_azs      = slice(data.aws_availability_zones.primary.names, 0, 3)

  secondary_region   = "us-east-1"
  secondary_vpc_cidr = "10.1.0.0/16"
  secondary_azs      = slice(data.aws_availability_zones.secondary.names, 0, 3)

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-rds-aurora"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# RDS Aurora Module
################################################################################

resource "aws_rds_global_cluster" "this" {
  global_cluster_identifier = local.name
  engine                    = "aurora-postgresql"
  engine_version            = "17.5"
  database_name             = "example_db"
  storage_encrypted         = true
}

module "aurora_primary" {
  source = "../../"

  name                      = local.name
  database_name             = aws_rds_global_cluster.this.database_name
  engine                    = aws_rds_global_cluster.this.engine
  engine_version            = aws_rds_global_cluster.this.engine_version
  master_username           = "root"
  global_cluster_identifier = aws_rds_global_cluster.this.id
  cluster_instance_class    = "db.r8g.large"
  instances                 = { for i in range(2) : i => {} }
  kms_key_id                = aws_kms_key.primary.arn

  vpc_id               = module.primary_vpc.vpc_id
  db_subnet_group_name = module.primary_vpc.database_subnet_group_name
  security_group_ingress_rules = {
    private-az1 = {
      cidr_ipv4 = element(module.primary_vpc.private_subnets_cidr_blocks, 0)
    }
    private-az2 = {
      cidr_ipv4 = element(module.primary_vpc.private_subnets_cidr_blocks, 1)
    }
    private-az3 = {
      cidr_ipv4 = element(module.primary_vpc.private_subnets_cidr_blocks, 2)
    }
  }

  # Global clusters do not support managed master user password
  master_password_wo         = random_password.master.result
  master_password_wo_version = 1

  skip_final_snapshot = true

  tags = local.tags
}

module "aurora_secondary" {
  source = "../../"

  region = local.secondary_region

  is_primary_cluster = false

  name                      = local.name
  engine                    = aws_rds_global_cluster.this.engine
  engine_version            = aws_rds_global_cluster.this.engine_version
  global_cluster_identifier = aws_rds_global_cluster.this.id
  source_region             = local.primary_region
  cluster_instance_class    = "db.r8g.large"
  instances                 = { for i in range(2) : i => {} }
  kms_key_id                = aws_kms_key.secondary.arn

  vpc_id               = module.secondary_vpc.vpc_id
  db_subnet_group_name = module.secondary_vpc.database_subnet_group_name
  security_group_ingress_rules = {
    private-az1 = {
      cidr_ipv4 = element(module.secondary_vpc.private_subnets_cidr_blocks, 0)
    }
    private-az2 = {
      cidr_ipv4 = element(module.secondary_vpc.private_subnets_cidr_blocks, 1)
    }
    private-az3 = {
      cidr_ipv4 = element(module.secondary_vpc.private_subnets_cidr_blocks, 2)
    }
  }

  # Global clusters do not support managed master user password
  master_password_wo         = random_password.master.result
  master_password_wo_version = 1

  skip_final_snapshot = true

  depends_on = [
    module.aurora_primary
  ]

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################

resource "random_password" "master" {
  length  = 20
  special = false
}

module "primary_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = local.name
  cidr = local.primary_vpc_cidr

  azs              = local.primary_azs
  public_subnets   = [for k, v in local.primary_azs : cidrsubnet(local.primary_vpc_cidr, 8, k)]
  private_subnets  = [for k, v in local.primary_azs : cidrsubnet(local.primary_vpc_cidr, 8, k + 3)]
  database_subnets = [for k, v in local.primary_azs : cidrsubnet(local.primary_vpc_cidr, 8, k + 6)]

  tags = local.tags
}


module "secondary_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  region = local.secondary_region

  name = local.name
  cidr = local.secondary_vpc_cidr

  azs              = local.secondary_azs
  public_subnets   = [for k, v in local.secondary_azs : cidrsubnet(local.secondary_vpc_cidr, 8, k)]
  private_subnets  = [for k, v in local.secondary_azs : cidrsubnet(local.secondary_vpc_cidr, 8, k + 3)]
  database_subnets = [for k, v in local.secondary_azs : cidrsubnet(local.secondary_vpc_cidr, 8, k + 6)]

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
  region = local.secondary_region

  policy = data.aws_iam_policy_document.rds.json
  tags   = local.tags
}
