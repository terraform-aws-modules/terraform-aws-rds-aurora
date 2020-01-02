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
  source                = "../../"
  name                  = "aurora-serverless"
  engine                = "aurora-postgresql"
  engine_mode           = "serverless"
  engine_version        = "10.7"
  replica_scale_enabled = false
  replica_count         = 0

  backtrack_window = 10 # ignored in serverless

  subnets                         = data.aws_subnet_ids.all.ids
  vpc_id                          = data.aws_vpc.default.id
  monitoring_interval             = 60
  instance_type                   = "db.r4.large" # ignored for serverless
  apply_immediately               = true
  skip_final_snapshot             = true
  storage_encrypted               = true
  db_parameter_group_name         = aws_db_parameter_group.aurora_db_postgresql10_parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_postgresql10_parameter_group.id

  scaling_configuration = {
    auto_pause               = true
    max_capacity             = 256
    min_capacity             = 2
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
}

resource "aws_db_parameter_group" "aurora_db_postgresql10_parameter_group" {
  name        = "test-postgresql10-parameter-group"
  family      = "aurora-postgresql10"
  description = "test-postgresql10-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_postgresql10_parameter_group" {
  name        = "test-postgresql10-cluster-parameter-group"
  family      = "aurora-postgresql10"
  description = "test-postgresql10-cluster-parameter-group"
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

