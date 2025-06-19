provider "aws" {
  region = local.region
}

provider "aws" {
  region = local.region2
  alias  = "region2"
}

locals {
  name           = "ex-${basename(path.cwd)}"
  region         = "us-east-1"
  region2        = "us-east-2"
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

  deletion_protection_enabled = false
  witness_region              = local.witness_region
  create_cluster_peering      = true
  clusters                    = [module.dsql_cluster_2.arn]

  timeouts = {
    create = "1h"
  }

  tags = merge(local.tags, { Name = local.name })
}

module "dsql_cluster_2" {
  source = "../../modules/dsql"

  deletion_protection_enabled = false
  witness_region              = local.witness_region
  create_cluster_peering      = true
  clusters                    = [module.dsql_cluster_1.arn]

  tags = merge(local.tags, { Name = local.name })

  providers = {
    aws = aws.region2
  }
}

module "dsql_single_region" {
  source = "../../modules/dsql"

  deletion_protection_enabled = false

  tags = merge(local.tags, { Name = "single-region" })
}
