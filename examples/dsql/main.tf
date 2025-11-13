provider "aws" {
  region = local.region
}

locals {
  name           = "ex-${basename(path.cwd)}"
  region         = "us-east-1"
  witness_region = "us-west-2"

  tags = {
    Example    = local.name
    GithubRepo = "terraform-aws-rds-aurora"
    GithubOrg  = "terraform-aws-modules"
  }
}

################################################################################
# RDS Aurora Module
################################################################################

module "dsql_cluster_1" {
  source = "../../modules/dsql"

  name = "${local.name}-1"

  # For example only
  deletion_protection_enabled = false

  witness_region         = local.witness_region
  create_cluster_peering = true
  clusters               = [module.dsql_cluster_2.arn]

  timeouts = {
    create = "1h"
  }

  tags = local.tags
}

module "dsql_cluster_2" {
  source = "../../modules/dsql"

  region = local.witness_region

  name = "${local.name}-2"

  # For example only
  deletion_protection_enabled = false

  witness_region         = local.region
  create_cluster_peering = true
  clusters               = [module.dsql_cluster_1.arn]

  tags = merge(local.tags, { Name = local.name })
}

module "dsql_single_region" {
  source = "../../modules/dsql"

  name = local.name

  # For example only
  deletion_protection_enabled = false

  tags = local.tags
}
