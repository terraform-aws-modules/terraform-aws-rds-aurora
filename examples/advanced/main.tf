provider "aws" {
  region = "us-east-1"
}

######################################
# Data sources to get VPC and subnets
######################################
data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

#############
# RDS Aurora
#############
module "aurora" {
  source                          = "../../"
  name                            = "aurora-example"
  engine                          = "aurora-postgresql"
  engine_version                  = "10.4"
  subnets                         = data.aws_subnet_ids.all.ids
  vpc_id                          = data.aws_vpc.default.id
  replica_count                   = 1
  replica_scale_enabled           = true
  replica_scale_min               = 1
  replica_scale_max               = 5
  monitoring_interval             = 60
  instance_type                   = "db.r4.large"
  instance_type_replica           = "db.t3.large"
  apply_immediately               = true
  skip_final_snapshot             = true
  db_parameter_group_name         = aws_db_parameter_group.aurora_db_postgres96_parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_postgres96_parameter_group.id
  #  enabled_cloudwatch_logs_exports = ["audit", "error", "general", "slowquery"]
}

resource "aws_db_parameter_group" "aurora_db_postgres96_parameter_group" {
  name        = "test-aurora-db-postgres10-parameter-group"
  family      = "aurora-postgresql10"
  description = "test-aurora-db-postgres10-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_postgres96_parameter_group" {
  name        = "test-aurora-postgres10-cluster-parameter-group"
  family      = "aurora-postgresql10"
  description = "test-aurora-postgres10-cluster-parameter-group"
}

############################
# Example of security group
############################
resource "aws_security_group" "app_servers" {
  name        = "app-servers"
  description = "For application servers"
  vpc_id      = data.aws_vpc.default.id
}

resource "aws_security_group_rule" "allow_access" {
  type                     = "ingress"
  from_port                = module.aurora.this_rds_cluster_port
  to_port                  = module.aurora.this_rds_cluster_port
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.app_servers.id
  security_group_id        = module.aurora.this_security_group_id
}

