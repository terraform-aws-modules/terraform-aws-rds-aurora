# Upgrade from v9.x to v10.x

If you have any questions regarding this upgrade process, please consult the `examples` directory.
If you find a bug, please open an issue with supporting configuration to reproduce.

## List of backwards incompatible changes

- Terraform `v1.11` is now minimum supported version to support write-only (`wo_*`) attributes.
- AWS provider `v6.18` is now minimum supported version
- The underlying `aws_security_group_rule` resources has been replaced with `aws_vpc_security_group_ingress_rule` and `aws_vpc_security_group_egress_rule` to allow for more flexibility in defining security group rules.
- `master_password` is no longer supported and only the write-only equivalent is supported (`master_password_wo` and `master_password_wo_version`) ([#513](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/pull/513))

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
    - `instance_class` -> still available within the `instances` variable definition
    - `monitoring_interval` -> still available within the `instances` variable definition
    - `performance_insights_enabled` -> still available within the `instances` variable definition
    - `performance_insights_kms_key_id` -> still available within the `instances` variable definition
    - `performance_insights_retention_period` -> still available within the `instances` variable definition
    - `iam_role_managed_policy_arns` -> deprecated argument on `aws_iam_role` resource
    - `iam_role_force_detach_policies` -> hardcode to `true`

2. Renamed variables:

    - `endpoints.cluster_endpoint_identifier` was previously `endpoints.identifier`
    - `endpoints.custom_endpoint_type` was previously `endpoints.type`
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

    -

4. Removed outputs:

    -

5. Renamed outputs:

    -

6. Added outputs:

    -

## Upgrade Migrations

### Before 9.x Example

```hcl
module "cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 9.0"

  # Only the affected attributes are shown


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

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

### State Changes
