# AWS RDS Aurora Terraform Serverless Example

## Usage
### Serverless PostgreSQL
Refer to [`main.tf](main.tf) for PostgreSQL usage example.

### Serverless MySQL 5.6
For MySQL, some minor modification will need to be made to the engine and the Parameter Group Family type.

```hcl
module "aurora" {
  engine                          = "aurora"
  engine_mode                     = "serverless"

  db_parameter_group_name         = aws_db_parameter_group.aurora_db_aurora56_parameter_group.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.aurora_cluster_aurora56_parameter_group.id
  ...
}
```

```hcl
resource "aws_db_parameter_group" "aurora_db_aurora56_parameter_group" {
  name        = "test-aurora56-parameter-group"
  family      = "aurora5.6"
  description = "test-aurora56-parameter-group"
}

resource "aws_rds_cluster_parameter_group" "aurora_cluster_aurora56_parameter_group" {
  name        = "test-aurora56-cluster-parameter-group"
  family      = "aurora5.6"
  description = "test-aurora56-cluster-parameter-group"
}
```