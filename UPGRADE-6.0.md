# Upgrade from v5.x to v6.x

If you have any questions regarding this upgrade process, please consult the `examples` directory:

- [Autoscaling](examples/autoscaling): A PostgreSQL cluster with enhanced monitoring and autoscaling enabled
- [Global Cluster](examples/global_cluster): A PostgreSQL global cluster with clusters provisioned in two different region
- [MySQL](examples/mysql): A simple MySQL cluster
- [PostgreSQL](examples/postgresql): A simple PostgreSQL cluster
- [S3 Import](examples/s3_import): A MySQL cluster created from a Percona Xtrabackup stored in S3
- [Serverless](examples/serverless): Serverless PostgreSQL and MySQL clusters

If you find a bug, please open an issue with supporting configuration to reproduce.

## Changes

- Added `create_db_subnet_group` variable to control whether a DB subnet group is created or not; previously if `db_subnet_group_name` was specified then an existing subnet group was used. Now the combination of `create_db_subnet_group` and `db_subnet_group_name` determine the name of the subnet group AND whether to create anew or use existing
- Minimum version of AWS provider increased to v3.63.0 to support features added
- Added `random_password_length` to give users control over the length of the random password that can be created; defaults to prior existing value of `10`
- Local variable check added on `aws_rds_cluster` for attributes `database_name`, `master_username` and `master_pass` to support secondary clusters (global cluster, replication cluster, etc.)
- Conditional creation check for `is_serverless` added to `aws_rds_cluster_instance`, `aws_appautoscaling_target`, and `aws_appautoscaling_policy` since these are not applicable for serverless clusters
- Added `availability_zone`, `copy_tags_to_snapshot` attributes to `aws_rds_cluster_instance` which are now accessible via the `instances` map
- Removed `engine_version` from `aws_rds_cluster_instance` lifecycle ignore block now that this has been [patched in upstream AWS provider](https://github.com/hashicorp/terraform-provider-aws/pull/17111)
- New resource `aws_rds_cluster_endpoint` added to allow for creation of custom, additional endpoints
- New resource `aws_rds_cluster_role_association` added to allow for association IAM roles with the cluster
- Where applicable, variable default values have been set to `null` to use upstream AWS provider default values
- Update variable descriptions from upstream provider docs

## List of backwards incompatible changes

- Coalesce of previous, default IAM enhanced monitoring role name has been removed (this was marked as a `TODO` to remove at next breaking change)
- `Name` tag removed from DB subnet group and enhanced monitoring role; the name is now set by the provider resource and this is no longer necessary
- `iam_roles` removed from `aws_rds_cluster` resource with the addition of `aws_rds_cluster_role_association`; per the docs this will cause conflicts and only one should be used and the role association resource contains more functionality/features
- `replication_source_identifier` added to `aws_rds_cluster` ignore lifecycle block to support [secondary, replication clusters per the docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster#replication_source_identifier)
- `global_cluster_identifier` added to `aws_rds_clsuter` ignore lifecycle block to support [global clusters per the docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_global_cluster#new-global-cluster-from-existing-db-cluster)
- `replica_count`replaced with `instances`; instances are now controlled by a map of maps, allowing users to create a homogenous cluster or a heterogenous cluster with fine grain control over the instances provisioned through the use of the new map attributes. This means the `aws_rds_cluster_instance` no longer uses `count` and now uses `for_each` for better stability and isolated change control.
- `iam_roles` variable has been re-purposed from a list of IAM roles to associate with the cluster via the `aws_rds_cluster` resource and instead is now a map of maps to associate roles via the new `aws_rds_cluster_role_association` resource
- `aws_appautoscaling_target` resource identifier changed from `read_replica_count` to `this` to follow conventions. This change requires either re-creation or a Terraform state rename to avoid disruption (see below)

### Variable and output changes

1. Removed variables:

   - `replica_count`replaced with `instances`; instances are now controlled by a map of maps, allowing users to create a homogenous cluster or a heterogenous cluster with fine grain control over the instances provisioned through the use of the new map attributes
   - `instances_parameters` - no longer required now that individual instance attributes are defined within the map of maps passed to `instances`
   - `instance_type_replica` - no longer required now that individual instance attributes are defined within the map of maps passed to `instances`

2. Renamed variables:

   - `password` -> `master_password` to match resource's convention
   - `username` -> `master_username` to match resource's convention'
   - `replica_scale_enabled` -> `autoscaling_enabled`
   - `replica_scale_min` -> `autoscaling_min_capacity`
   - `replica_scale_max` -> `autoscaling_max_capacity`
   - `replica_scale_cpu` -> `autoscaling_target_cpu`
   - `replica_scale_connections` -> `autoscaling_target_connections`

3. Added variables:

   - `create_db_subnet_group` to control whether a DB subnet group is created or not; previously controlled by whether `db_subnet_group_name` was specified or not
   - `random_password_length` to give users control over the length of the random password that can be created
   - `enable_global_write_forwarding` to support the same attribute on `aws_rds_cluster`
   - `performance_insights_retention_period` to support the same attribute on `aws_rds_cluster`
   - `db_cluster_db_instance_parameter_group_name` to support the `db_instance_parameter_group_name` attribute on `aws_rds_cluster`
   - `cluster_timeouts` to support `create`, `update`, and `delete` timeouts on `aws_rds_cluster`
   - `instances_use_identifier_prefix` to enable the option of using a prefix name strategy on cluster instances created
   - `instance_timeouts` to support `create`, `update`, and `delete` timeouts on `aws_rds_cluster_instance`
   - `endpoints` to support new resources `aws_rds_cluster_endpoint` resource(s)

4. Removed outputs:

   - `rds_cluster_instance_*` outputs have been removed in favor of one output `cluster_instances` which contains a map of all instances created and their attributes

5. Renamed outputs:

   - Outputs that started with `rds_cluster_*` have been updated to start with `cluster_*` (dropping the preceding `rds_`)

6. Added outputs:

   - `db_subnet_group_name`
   - `cluster_members`
   - `cluster_engine_version_actual`
   - `additional_cluster_endpoints`
   - `cluster_role_associations`

## Upgrade Migrations

### Before 5.x Example

```hcl
module "cluster_before" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 5.0"

  name            = "before-5.x"
  engine          = "aurora-postgresql"
  engine_version  = "11.9"
  instance_type   = "db.r5.large"
  - replica_count = 3

  - instances_parameters = [
    # List index should be equal to `replica_count`
    # Omitted keys replaced by module defaults
    {
      instance_type       = "db.r5.2xlarge"
      publicly_accessible = true
    },
    {
      instance_type = "db.r5.2xlarge"
    },
    {
      instance_name           = "reporting"
      instance_type           = "db.r5.large"
      instance_promotion_tier = 15
    }
  ]

  - autoscaling_enabled      = true
  - autoscaling_min_capacity = 1
  - autoscaling_max_capacity = 5

  vpc_id  = "vpc-12345678"
  subnets = ["subnet-12345678", "subnet-87654321"]

  allowed_security_groups = ["sg-12345678"]
  allowed_cidr_blocks     = ["10.20.0.0/20"]

  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 10

  db_parameter_group_name         = "default"
  db_cluster_parameter_group_name = "default"

  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

### After 6.x Example

```hcl
module "cluster_after" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 6.0"

  name           = "after-6.x"
  engine         = "aurora-postgresql"
  engine_version = "11.9"
  instance_type  = "db.r5.large"

  + instances = {
    1 = {
      instance_class      = "db.r5.2xlarge"
      publicly_accessible = true
    }
    2 = {
      instance_class = "db.r5.2xlarge"
    }
    3 = {
      identifier              = "reporting"
      instance_class          = "db.r5.large"
      instance_promotion_tier = 15
    }
  }

  + autoscaling_enabled      = true
  + autoscaling_min_capacity = 1
  + autoscaling_max_capacity = 5

  vpc_id  = "vpc-12345678"
  subnets = ["subnet-12345678", "subnet-87654321"]

  allowed_security_groups = ["sg-12345678"]
  allowed_cidr_blocks     = ["10.20.0.0/20"]

  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 10

  db_parameter_group_name         = "default"
  db_cluster_parameter_group_name = "default"

  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

### State Changes

To migrate from the `v5.x` version to `v6.x` version example shown above, the following state move commands can be performed to maintain the current resources without modification:

```bash
terraform state mv 'module.cluster_before.aws_rds_cluster_instance.this[0]' 'module.cluster_after.aws_rds_cluster_instance.this["1"]'
# Note: this move will need to be made for each instance in the cluster, where `<index>` is the instance creation index/position and is mapped to its new `<key>` specified
# in the `var.instances` map. See next line for rough pattern to follow for all instances in your cluster
# terraform state mv 'module.cluster_before.aws_rds_cluster_instance.this[<index>]' 'module.cluster_after.aws_rds_cluster_instance.this["<key>"]'

terraform state mv 'module.cluster_before.aws_appautoscaling_policy.autoscaling_read_replica_count[0]' 'module.cluster_after.aws_appautoscaling_policy.this[0]'
terraform state mv 'module.cluster_before.aws_appautoscaling_target.read_replica_count[0]' 'module.cluster_after.aws_appautoscaling_target.this[0]'
```

For example, if you previously had a configuration such as (truncated for brevity):

```hcl
module "aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 5.x"

  instance_type         = "db.r5.large"
  instance_type_replica = "db.t3.medium"
  replica_count         = 2
  replica_scale_enabled = true
  replica_scale_min     = 2
  replica_scale_max     = 5
```

After updating the configuration to the latest 6.x changes:

```hcl
module "aurora" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 6.x"

  instance_class = "db.r5.large"
  instances = {
    1 = {
      promotion_tier = 1
    }
    2 = {
      instance_class = "db.t3.medium"
      promotion_tier = 2
    }

  autoscaling_enabled      = true
  autoscaling_min_capacity = 2
  autoscaling_max_capacity = 5
```

The associated Terraform state move commands would be:

```bash
terraform state mv 'module.aurora.aws_rds_cluster_instance.this[0]' 'module.aurora.aws_rds_cluster_instance.this["1"]'
terraform state mv 'module.aurora.aws_rds_cluster_instance.this[1]' 'module.aurora.aws_rds_cluster_instance.this["2"]'

terraform state mv 'module.aurora.aws_appautoscaling_policy.autoscaling_read_replica_count[0]' 'module.aurora.aws_appautoscaling_policy.this[0]'
terraform state mv 'module.aurora.aws_appautoscaling_target.read_replica_count[0]' 'module.aurora.aws_appautoscaling_target.this[0]'
```

### Configuration Changes

To avoid re-creation of the security group created by the module, you can add the following attribute and value:
```hcl
  security_group_description = "Managed by Terraform"
```
