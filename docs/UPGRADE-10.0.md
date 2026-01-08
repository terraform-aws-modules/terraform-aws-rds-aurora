# Upgrade from v9.x to v10.x

If you have any questions regarding this upgrade process, please consult the `examples` directory.
If you find a bug, please open an issue with supporting configuration to reproduce.

## List of backwards incompatible changes

- Terraform `v1.11.1` is now minimum supported version to support write-only (`wo_*`) attributes.
- AWS provider `v6.18` is now minimum supported version
- The underlying `aws_security_group_rule` resources has been replaced with `aws_vpc_security_group_ingress_rule` and `aws_vpc_security_group_egress_rule` to allow for more flexibility in defining security group rules.
- `master_password` is no longer supported and only the write-only equivalent is supported (`master_password_wo` and `master_password_wo_version`) ([#513](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/pull/513))
- `security_group_rules` has been split into `security_group_ingress_rules` and `security_group_egress_rules` to better match the AWS API and allow for more flexibility in defining security group rules

## Additional changes

### Added

- Support for `region` argument to specify the AWS region for the resources created if different from the provider region.

### Modified

- Variable definitions now contain detailed object types in place of the previously used `any` type
- `copy_tags_to_snapshot` default value is now `true` ([#521](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/issues/521))
- `db_cluster_parameter_group_parameters` was previously of type `list(map(...))`, now of type `map(object(...))`with `name` being optional and defaulting to the map key if not provided
- `preferred_maintenance_window` and `preferred_backup_window` default values are now `null` ([#524](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/pull/524))

### Removed

- None

### Variable and output changes

1. Removed variables:

    - `auto_minor_version_upgrade` -> still available within the `instances` variable definition
    - `ca_cert_identifier` -> available within the `instances` variable definition
    - `monitoring_interval` -> still available within the `instances` variable definition
    - `performance_insights_enabled` -> still available within the `instances` variable definition
    - `performance_insights_kms_key_id` -> still available within the `instances` variable definition
    - `performance_insights_retention_period` -> still available within the `instances` variable definition
    - `iam_role_managed_policy_arns` -> deprecated argument on `aws_iam_role` resource
    - `iam_role_force_detach_policies` -> hardcode to `true`

2. Renamed variables:

    - `instance_class` -> `cluster_instance_class`
    - `db_cluster_db_instance_parameter_group_name` -> `cluster_db_instance_parameter_group_name`
    - `role_associations` was previously `iam_roles`
    - `master_password` replaced with `master_password_wo` and `master_password_wo_version`
    - The variables for DB shard group have been nested under a single, top-level `shard_group` variable:
      - `create_shard_group` removed - set `shard_group` to `null` to disable or provide an object to enable
      - `compute_redundancy` -> `shard_group.compute_redundancy`
      - `db_shard_group_identifier` -> `shard_group.identifier`
      - `max_acu` -> `shard_group.max_acu`
      - `min_acu` -> `shard_group.min_acu`
      - `publicly_accessible` -> `shard_group.publicly_accessible`
      - `shard_group_tags` -> `shard_group.tags`
      - `shard_group_timeouts` -> `shard_group.timeouts`
    - The variables for the cluster activity stream have been nested under a single, top-level `cluster_activity_stream` variable:
      - `create_db_cluster_activity_stream` removed - set `cluster_activity_stream` to `null` to disable or provide an object to enable
      - `db_cluster_activity_stream_mode` -> `cluster_activity_stream.mode`
      - `db_cluster_activity_stream_kms_key_id` -> `cluster_activity_stream.kms_key_id`
      - `engine_native_audit_fields_included` -> `cluster_activity_stream.include_audit_fields`
    - The variables for the cluster parameter group have been nested under a single, top-level `cluster_parameter_group` variable:
      - `create_db_cluster_parameter_group` removed - set `cluster_parameter_group` to `null` to disable or provide an object to enable
      - `db_cluster_parameter_group_name` -> `cluster_parameter_group.name`
      - `db_cluster_parameter_group_use_name_prefix` -> `cluster_parameter_group.use_name_prefix`
      - `db_cluster_parameter_group_description` -> `cluster_parameter_group.description`
      - `db_cluster_parameter_group_family` -> `cluster_parameter_group.family`
      - `db_cluster_parameter_group_parameters` -> `cluster_parameter_group.parameters`
    - The variables for the instance parameter group have been nested under a single, top-level `db_parameter_group` variable:
      - `create_db_parameter_group` removed - set `db_parameter_group` to `null` to disable or provide an object to enable
      - `db_parameter_group_name` -> `db_parameter_group.name`
        - A variable `cluster_parameter_group_name` has been retained for when users want to provide an existing cluster parameter group name.
      - `db_parameter_group_use_name_prefix` -> `db_parameter_group.use_name_prefix`
      - `db_parameter_group_description` -> `db_parameter_group.description`
      - `db_parameter_group_family` -> `db_parameter_group.family`
      - `db_parameter_group_parameters` -> `db_parameter_group.parameters`

3. Added variables:

    - `region`

4. Removed outputs:

    - `cluster_master_password`

5. Renamed outputs:

    - None

6. Added outputs:

    - None

## Upgrade Migrations

### Before 9.x Example

```hcl
module "cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 9.0"

  # Only the affected attributes are shown
  instance_class      = "db.r8g.large"
  monitoring_interval = 60

  security_group_rules = {
    vpc_ingress = {
      cidr_blocks = module.vpc.private_subnets_cidr_blocks
    }
  }

  master_password = random_password.master.result

  # For limitless databases
  create_shard_group        = true
  compute_redundancy        = 0
  db_shard_group_identifier = "example"
  max_acu                   = 16

  create_db_cluster_parameter_group      = true
  db_cluster_parameter_group_name        = "example"
  db_cluster_parameter_group_family      = "aurora-postgresql16"
  db_cluster_parameter_group_description = "Example cluster parameter group"
  db_cluster_parameter_group_parameters = [
    {
      name         = "log_min_duration_statement"
      value        = 4000
      apply_method = "immediate"
      }, {
      name         = "rds.force_ssl"
      value        = 1
      apply_method = "immediate"
    }
  ]

  create_db_parameter_group      = true
  db_parameter_group_name        = "example"
  db_parameter_group_family      = "aurora-mysql8.0"
  db_parameter_group_description = "Example DB parameter group"
  db_parameter_group_parameters = [
    {
      name         = "connect_timeout"
      value        = 60
      apply_method = "immediate"
    },
  ]

  create_db_cluster_activity_stream     = true
  db_cluster_activity_stream_kms_key_id = module.kms.key_id
  db_cluster_activity_stream_mode = "async"

  iam_roles = {
    s3_import = {
      role_arn     = aws_iam_role.s3_import.arn
      feature_name = "s3Import"
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

### After 10.x Example

```hcl
module "cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 10.0"

  # Only the affected attributes are shown
  cluster_instance_class   = "db.r8g.large"
  cluster_monitoring_interval = 60

  security_group_ingress_rules = {
    private-az1 = {
      cidr_ipv4 = element(module.vpc.private_subnets_cidr_blocks, 0)
    }
    private-az2 = {
      cidr_ipv4 = element(module.vpc.private_subnets_cidr_blocks, 1)
    }
    private-az3 = {
      cidr_ipv4 = element(module.vpc.private_subnets_cidr_blocks, 2)
    }
  }

  master_password_wo         = random_password.master.result
  master_password_wo_version = 1

  # For limitless databases
  shard_group = {
    compute_redundancy = 0
    identifier         = "example"
    max_acu            = 16
  }

  cluster_parameter_group = {
    name        = "example"
    family      = "aurora-postgresql16"
    description = "Example cluster parameter group"
    parameters = [
      {
        name         = "log_min_duration_statement"
        value        = 4000
        apply_method = "immediate"
        }, {
        name         = "rds.force_ssl"
        value        = 1
        apply_method = "immediate"
      }
    ]
  }

  db_parameter_group = {
    name        = "example"
    family      = "aurora-mysql8.0"
    description = "Example DB parameter group"
    parameters = [
      {
        name         = "connect_timeout"
        value        = 60
        apply_method = "immediate"
      },
    ]
  }

  cluster_activity_stream = {
    kms_key_id = module.kms.key_id
    mode       = "async"
  }

  role_associations = {
    s3Import = {
      role_arn = aws_iam_role.s3_import.arn
      # feature_name = "s3Import" # same as setting value to key
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

### State Changes

Due to the change from `aws_security_group_rule` to `aws_vpc_security_group_ingress_rule` and `aws_vpc_security_group_egress_rule`, the following reference state changes are required to maintain the current security group rules. (Note: these are different resource types so they cannot be moved with `terraform mv ...`)

```sh
terraform state rm 'module.aurora.aws_security_group_rule.this["vpc_ingress"]'
terraform state import 'module.aurora.aws_vpc_security_group_ingress_rule.this["private-az1"]' 'sg-xxx'
terraform state import 'module.aurora.aws_vpc_security_group_ingress_rule.this["private-az2"]' 'sg-xxx'
terraform state import 'module.aurora.aws_vpc_security_group_ingress_rule.this["private-az3"]' 'sg-xxx'
```
