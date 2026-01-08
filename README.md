# AWS RDS Aurora Terraform module

Terraform module which creates AWS RDS Aurora resources.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Available Features

- Autoscaling of read-replicas
- Global cluster
- Enhanced monitoring
- Serverless cluster (v1 and v2)
- Import from S3
- Fine grained control of individual cluster instances
- Custom endpoints
- RDS multi-AZ support (not Aurora)
- Aurora Limitless
- Aurora DSQL cluster

## Usage

```hcl
module "cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"

  name           = "test-aurora-db-postgres96"
  engine         = "aurora-postgresql"
  engine_version = "17.5"

  cluster_instance_class = "db.r8g.large"
  instances = {
    one = {}
    two = {
      instance_class = "db.r8g.2xlarge"
    }
  }

  vpc_id               = "vpc-12345678"
  db_subnet_group_name = "db-subnet-group"
  security_group_ingress_rules = {
    ex1_ingress = {
      cidr_ipv4 = "10.20.0.0/20"
    }
    ex1_ingress = {
      referenced_security_group_id = "sg-12345678"
    }
  }

  storage_encrypted   = true
  apply_immediately   = true
  monitoring_interval = 10

  enabled_cloudwatch_logs_exports = ["postgresql"]

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
```

### Cluster Instance Configuration

There are a couple different configuration methods that can be used to create instances within the cluster:

  > [!NOTE]
  > Only the pertinent attributes are shown for brevity

  1. Create homogenous cluster of any number of instances

  - Resources created:
    - Writer: 1
    - Reader(s): 2

  ```hcl
    cluster_instance_class = "db.r8g.large"
    instances = {
      one   = {}
      two   = {}
      three = {}
    }
  ```

2. Create homogenous cluster of instances w/ autoscaling enabled. This is redundant and we'll show why in the next example.

  - Resources created:
    - Writer: 1
    - Reader(s):
      - At least 4 readers (2 created directly, 2 created by appautoscaling)
      - At most 7 reader instances (2 created directly, 5 created by appautoscaling)

  > [!NOTE]
  > Autoscaling uses the instance class specified by `cluster_instance_class`.

  ```hcl
    cluster_instance_class = "db.r8g.large"
    instances = {
      one   = {}
      two   = {}
      three = {}
    }

    autoscaling_enabled      = true
    autoscaling_min_capacity = 2
    autoscaling_max_capacity = 5
  ```

3. Create homogeneous cluster scaled via autoscaling. At least one instance (writer) is required

  - Resources created:
    - Writer: 1
    - Reader(s):
      - At least 1 reader
      - At most 5 readers

  ```hcl
    cluster_instance_class = "db.r8g.large"
    instances = {
      one = {}
    }

    autoscaling_enabled      = true
    autoscaling_min_capacity = 1
    autoscaling_max_capacity = 5
  ```

4. Create heterogenous cluster to support mixed-use workloads

    It is common in this configuration to independently control the instance `promotion_tier` paired with `endpoints` to create custom endpoints directed at select instances or instance groups.

  - Resources created:
    - Writer: 1
    - Readers: 2

  ```hcl
    cluster_instance_class = "db.r8g.large"
    instances = {
      one = {
        instance_class      = "db.r8g.2xlarge"
        publicly_accessible = true
      }
      two = {
        identifier     = "static-member-1"
        instance_class = "db.r8g.2xlarge"
      }
      three = {
        identifier     = "excluded-member-1"
        instance_class = "db.r8g.large"
        promotion_tier = 15
      }
    }
  ```

5. Create heterogenous cluster to support mixed-use workloads w/ autoscaling enabled

  - Resources created:
    - Writer: 1
    - Reader(s):
      - At least 3 readers (2 created directly, 1 created through appautoscaling)
      - At most 7 readers (2 created directly, 5 created through appautoscaling)

  > [!NOTE]
  > Autoscaling uses the instance class specified by `cluster_instance_class`.

  ```hcl
    cluster_instance_class = "db.r8g.large"
    instances = {
      one = {
        instance_class      = "db.r8g.2xlarge"
        publicly_accessible = true
      }
      two = {
        identifier     = "static-member-1"
        instance_class = "db.r8g.2xlarge"
      }
      three = {
        identifier     = "excluded-member-1"
        instance_class = "db.r8g.large"
        promotion_tier = 15
      }
    }

    autoscaling_enabled      = true
    autoscaling_min_capacity = 1
    autoscaling_max_capacity = 5
  ```

## Conditional Creation

The following values are provided to toggle on/off creation of the associated resources as desired:

```hcl
# This RDS cluster will not be created
module "cluster" {
  source  = "terraform-aws-modules/rds-aurora/aws"

  # Disable creation of cluster and all resources
  create = false

  # Disable creation of subnet group - provide a subnet group
  create_db_subnet_group = false

  # Disable creation of security group - provide a security group
  create_security_group = false

  # Disable creation of monitoring IAM role - provide a role ARN
  create_monitoring_role = false

  # ... omitted
}
```

## Examples

- [Autoscaling](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/tree/master/examples/autoscaling): A PostgreSQL cluster with enhanced monitoring and autoscaling enabled
- [DSQL](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/tree/master/examples/dsql): Multi region and single region DSQL clusters
- [Global Cluster](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/tree/master/examples/global-cluster): A PostgreSQL global cluster with clusters provisioned in two different region
- [Limitless](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/tree/master/examples/limitless): A PostgreSQL Limitless cluster
- [Multi-AZ](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/tree/master/examples/multi-az): A multi-AZ RDS cluster (not using Aurora engine)
- [MySQL](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/tree/master/examples/mysql): A simple MySQL cluster
- [PostgreSQL](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/tree/master/examples/postgresql): A simple PostgreSQL cluster
- [S3 Import](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/tree/master/examples/s3-import): A MySQL cluster created from a Percona Xtrabackup stored in S3
- [Serverless](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/tree/master/examples/serverless): Serverless V1 and V2 (PostgreSQL and MySQL)

## Documentation

Terraform documentation is generated automatically using [pre-commit hooks](http://www.pre-commit.com/). Follow installation instructions [here](https://pre-commit.com/#install).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.28 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.28 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_appautoscaling_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_policy) | resource |
| [aws_appautoscaling_target.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/appautoscaling_target) | resource |
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_db_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_db_subnet_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_iam_role.rds_enhanced_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.rds_enhanced_monitoring](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_rds_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster) | resource |
| [aws_rds_cluster_activity_stream.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_activity_stream) | resource |
| [aws_rds_cluster_endpoint.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_endpoint) | resource |
| [aws_rds_cluster_instance.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_instance) | resource |
| [aws_rds_cluster_parameter_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |
| [aws_rds_cluster_role_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_role_association) | resource |
| [aws_rds_shard_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_shard_group) | resource |
| [aws_secretsmanager_secret_rotation.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_rotation) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_iam_policy_document.monitoring_rds_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_service_principal.monitoring_rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/service_principal) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | The amount of storage in gibibytes (GiB) to allocate to each DB instance in the Multi-AZ DB cluster. (This setting is required to create a Multi-AZ DB cluster) | `number` | `null` | no |
| <a name="input_allow_major_version_upgrade"></a> [allow\_major\_version\_upgrade](#input\_allow\_major\_version\_upgrade) | Enable to allow major engine version upgrades when changing engine versions. Defaults to `false` | `bool` | `false` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | Specifies whether any cluster modifications are applied immediately, or during the next maintenance window. Default is `false` | `bool` | `null` | no |
| <a name="input_autoscaling_enabled"></a> [autoscaling\_enabled](#input\_autoscaling\_enabled) | Determines whether autoscaling of the cluster read replicas is enabled | `bool` | `false` | no |
| <a name="input_autoscaling_max_capacity"></a> [autoscaling\_max\_capacity](#input\_autoscaling\_max\_capacity) | Maximum number of read replicas permitted when autoscaling is enabled | `number` | `2` | no |
| <a name="input_autoscaling_min_capacity"></a> [autoscaling\_min\_capacity](#input\_autoscaling\_min\_capacity) | Minimum number of read replicas permitted when autoscaling is enabled | `number` | `0` | no |
| <a name="input_autoscaling_policy_name"></a> [autoscaling\_policy\_name](#input\_autoscaling\_policy\_name) | Autoscaling policy name | `string` | `"target-metric"` | no |
| <a name="input_autoscaling_scale_in_cooldown"></a> [autoscaling\_scale\_in\_cooldown](#input\_autoscaling\_scale\_in\_cooldown) | Cooldown in seconds before allowing further scaling operations after a scale in | `number` | `300` | no |
| <a name="input_autoscaling_scale_out_cooldown"></a> [autoscaling\_scale\_out\_cooldown](#input\_autoscaling\_scale\_out\_cooldown) | Cooldown in seconds before allowing further scaling operations after a scale out | `number` | `300` | no |
| <a name="input_autoscaling_target_connections"></a> [autoscaling\_target\_connections](#input\_autoscaling\_target\_connections) | Average number of connections threshold which will initiate autoscaling. Default value is 70% of db.r4/r5/r6g.large's default max\_connections | `number` | `700` | no |
| <a name="input_autoscaling_target_cpu"></a> [autoscaling\_target\_cpu](#input\_autoscaling\_target\_cpu) | CPU threshold which will initiate autoscaling | `number` | `70` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | List of EC2 Availability Zones for the DB cluster storage where DB cluster instances can be created. RDS automatically assigns 3 AZs if less than 3 AZs are configured, which will show as a difference requiring resource recreation next Terraform apply | `list(string)` | `null` | no |
| <a name="input_backtrack_window"></a> [backtrack\_window](#input\_backtrack\_window) | The target backtrack window, in seconds. Only available for `aurora` engine currently. To disable backtracking, set this value to 0. Must be between 0 and 259200 (72 hours) | `number` | `null` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for | `number` | `null` | no |
| <a name="input_cloudwatch_log_group_class"></a> [cloudwatch\_log\_group\_class](#input\_cloudwatch\_log\_group\_class) | Specified the log class of the log group. Possible values are: STANDARD or INFREQUENT\_ACCESS | `string` | `null` | no |
| <a name="input_cloudwatch_log_group_kms_key_id"></a> [cloudwatch\_log\_group\_kms\_key\_id](#input\_cloudwatch\_log\_group\_kms\_key\_id) | The ARN of the KMS Key to use when encrypting log data | `string` | `null` | no |
| <a name="input_cloudwatch_log_group_retention_in_days"></a> [cloudwatch\_log\_group\_retention\_in\_days](#input\_cloudwatch\_log\_group\_retention\_in\_days) | The number of days to retain CloudWatch logs for the DB instance | `number` | `7` | no |
| <a name="input_cloudwatch_log_group_skip_destroy"></a> [cloudwatch\_log\_group\_skip\_destroy](#input\_cloudwatch\_log\_group\_skip\_destroy) | Set to true if you do not wish the log group (and any logs it may contain) to be deleted at destroy time, and instead just remove the log group from the Terraform state | `bool` | `null` | no |
| <a name="input_cloudwatch_log_group_tags"></a> [cloudwatch\_log\_group\_tags](#input\_cloudwatch\_log\_group\_tags) | Additional tags for the CloudWatch log group(s) | `map(string)` | `{}` | no |
| <a name="input_cluster_activity_stream"></a> [cluster\_activity\_stream](#input\_cluster\_activity\_stream) | Map of arguments for the created DB cluster activity stream | <pre>object({<br/>    include_audit_fields = optional(bool, false)<br/>    kms_key_id           = string<br/>    mode                 = string<br/>  })</pre> | `null` | no |
| <a name="input_cluster_ca_cert_identifier"></a> [cluster\_ca\_cert\_identifier](#input\_cluster\_ca\_cert\_identifier) | The CA certificate identifier to use for the DB cluster's server certificate. Currently only supported for multi-az DB clusters | `string` | `null` | no |
| <a name="input_cluster_db_instance_parameter_group_name"></a> [cluster\_db\_instance\_parameter\_group\_name](#input\_cluster\_db\_instance\_parameter\_group\_name) | Instance parameter group to associate with all instances of the DB cluster. The `cluster_db_instance_parameter_group_name` is only valid in combination with `allow_major_version_upgrade` | `string` | `null` | no |
| <a name="input_cluster_instance_class"></a> [cluster\_instance\_class](#input\_cluster\_instance\_class) | The compute and memory capacity of each DB instance in the Multi-AZ DB cluster (not all DB instance classes are available in all AWS Regions, or for all database engines) | `string` | `null` | no |
| <a name="input_cluster_members"></a> [cluster\_members](#input\_cluster\_members) | List of RDS Instances that are a part of this cluster | `list(string)` | `null` | no |
| <a name="input_cluster_monitoring_interval"></a> [cluster\_monitoring\_interval](#input\_cluster\_monitoring\_interval) | Interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB cluster. To turn off collecting Enhanced Monitoring metrics, specify 0. Valid Values: 0, 1, 5, 10, 15, 30, 60 | `number` | `0` | no |
| <a name="input_cluster_parameter_group"></a> [cluster\_parameter\_group](#input\_cluster\_parameter\_group) | Map of nested arguments for the created DB cluster parameter group | <pre>object({<br/>    name            = optional(string)<br/>    use_name_prefix = optional(bool, true)<br/>    description     = optional(string)<br/>    family          = string<br/>    parameters = optional(list(object({<br/>      name         = string<br/>      value        = string<br/>      apply_method = optional(string, "immediate")<br/>    })))<br/>  })</pre> | `null` | no |
| <a name="input_cluster_parameter_group_name"></a> [cluster\_parameter\_group\_name](#input\_cluster\_parameter\_group\_name) | The name of an existing DB cluster parameter group. Required when `cluster_parameter_group` is not provided (`null`) | `string` | `null` | no |
| <a name="input_cluster_performance_insights_enabled"></a> [cluster\_performance\_insights\_enabled](#input\_cluster\_performance\_insights\_enabled) | Enables Performance Insights for the RDS Cluster | `bool` | `null` | no |
| <a name="input_cluster_performance_insights_kms_key_id"></a> [cluster\_performance\_insights\_kms\_key\_id](#input\_cluster\_performance\_insights\_kms\_key\_id) | Specifies the KMS Key ID to encrypt Performance Insights data. If not specified, the default RDS KMS key will be used (aws/rds) | `string` | `null` | no |
| <a name="input_cluster_performance_insights_retention_period"></a> [cluster\_performance\_insights\_retention\_period](#input\_cluster\_performance\_insights\_retention\_period) | Specifies the amount of time to retain performance insights data for. Defaults to 7 days if Performance Insights are enabled. Valid values are 7, month * 31 (where month is a number of months from 1-23), and 731 | `number` | `null` | no |
| <a name="input_cluster_scalability_type"></a> [cluster\_scalability\_type](#input\_cluster\_scalability\_type) | Specifies the scalability mode of the Aurora DB cluster. When set to limitless, the cluster operates as an Aurora Limitless Database. When set to standard (the default), the cluster uses normal DB instance creation. Valid values: limitless, standard | `string` | `null` | no |
| <a name="input_cluster_tags"></a> [cluster\_tags](#input\_cluster\_tags) | A map of tags to add to only the cluster. Used for AWS Instance Scheduler tagging | `map(string)` | `{}` | no |
| <a name="input_cluster_timeouts"></a> [cluster\_timeouts](#input\_cluster\_timeouts) | Create, update, and delete timeout configurations for the cluster | <pre>object({<br/>    create = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_cluster_use_name_prefix"></a> [cluster\_use\_name\_prefix](#input\_cluster\_use\_name\_prefix) | Whether to use `name` as a prefix for the cluster | `bool` | `false` | no |
| <a name="input_copy_tags_to_snapshot"></a> [copy\_tags\_to\_snapshot](#input\_copy\_tags\_to\_snapshot) | Copy all Cluster `tags` to snapshots | `bool` | `true` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether cluster should be created (affects nearly all resources) | `bool` | `true` | no |
| <a name="input_create_cloudwatch_log_group"></a> [create\_cloudwatch\_log\_group](#input\_create\_cloudwatch\_log\_group) | Determines whether a CloudWatch log group is created for each `enabled_cloudwatch_logs_exports` | `bool` | `false` | no |
| <a name="input_create_db_subnet_group"></a> [create\_db\_subnet\_group](#input\_create\_db\_subnet\_group) | Determines whether to create the database subnet group or use existing | `bool` | `false` | no |
| <a name="input_create_monitoring_role"></a> [create\_monitoring\_role](#input\_create\_monitoring\_role) | Determines whether to create the IAM role for RDS enhanced monitoring | `bool` | `true` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Determines whether to create security group for RDS cluster | `bool` | `true` | no |
| <a name="input_database_insights_mode"></a> [database\_insights\_mode](#input\_database\_insights\_mode) | The mode of Database Insights to enable for the DB cluster. Valid values: standard, advanced | `string` | `null` | no |
| <a name="input_database_name"></a> [database\_name](#input\_database\_name) | Name for an automatically created database on cluster creation | `string` | `null` | no |
| <a name="input_db_parameter_group"></a> [db\_parameter\_group](#input\_db\_parameter\_group) | Map of nested arguments for the created DB parameter group | <pre>object({<br/>    name            = optional(string)<br/>    use_name_prefix = optional(bool, true)<br/>    description     = optional(string)<br/>    family          = string<br/>    parameters = optional(list(object({<br/>      name         = string<br/>      value        = string<br/>      apply_method = optional(string, "immediate")<br/>    })))<br/>  })</pre> | `null` | no |
| <a name="input_db_subnet_group_name"></a> [db\_subnet\_group\_name](#input\_db\_subnet\_group\_name) | The name of the subnet group name (existing or created) | `string` | `""` | no |
| <a name="input_delete_automated_backups"></a> [delete\_automated\_backups](#input\_delete\_automated\_backups) | Specifies whether to remove automated backups immediately after the DB cluster is deleted | `bool` | `null` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | If the DB instance should have deletion protection enabled. The database can't be deleted when this value is set to `true`. The default is `false` | `bool` | `null` | no |
| <a name="input_domain"></a> [domain](#input\_domain) | The ID of the Directory Service Active Directory domain to create the instance in | `string` | `null` | no |
| <a name="input_domain_iam_role_name"></a> [domain\_iam\_role\_name](#input\_domain\_iam\_role\_name) | (Required if domain is provided) The name of the IAM role to be used when making API calls to the Directory Service | `string` | `null` | no |
| <a name="input_enable_global_write_forwarding"></a> [enable\_global\_write\_forwarding](#input\_enable\_global\_write\_forwarding) | Whether cluster should forward writes to an associated global cluster. Applied to secondary clusters to enable them to forward writes to an `aws_rds_global_cluster`'s primary cluster | `bool` | `null` | no |
| <a name="input_enable_http_endpoint"></a> [enable\_http\_endpoint](#input\_enable\_http\_endpoint) | Enable HTTP endpoint (data API). Only valid when engine\_mode is set to `serverless` | `bool` | `null` | no |
| <a name="input_enable_local_write_forwarding"></a> [enable\_local\_write\_forwarding](#input\_enable\_local\_write\_forwarding) | Whether read replicas can forward write operations to the writer DB instance in the DB cluster. By default, write operations aren't allowed on reader DB instances | `bool` | `null` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | Set of log types to export to cloudwatch. If omitted, no logs will be exported. The following log types are supported: `audit`, `error`, `general`, `slowquery`, `postgresql` | `list(string)` | `[]` | no |
| <a name="input_endpoints"></a> [endpoints](#input\_endpoints) | Map of additional cluster endpoints and their attributes to be created | <pre>map(object({<br/>    identifier       = string<br/>    type             = string<br/>    excluded_members = optional(list(string))<br/>    static_members   = optional(list(string))<br/>    tags             = optional(map(string), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The name of the database engine to be used for this DB cluster. Defaults to `aurora`. Valid Values: `aurora`, `aurora-mysql`, `aurora-postgresql` | `string` | `null` | no |
| <a name="input_engine_lifecycle_support"></a> [engine\_lifecycle\_support](#input\_engine\_lifecycle\_support) | The life cycle type for this DB instance. This setting is valid for cluster types Aurora DB clusters and Multi-AZ DB clusters. Valid values are `open-source-rds-extended-support`, `open-source-rds-extended-support-disabled`. Default value is `open-source-rds-extended-support` | `string` | `null` | no |
| <a name="input_engine_mode"></a> [engine\_mode](#input\_engine\_mode) | The database engine mode. Valid values: `global`, `multimaster`, `parallelquery`, `provisioned`, `serverless`. Defaults to: `provisioned` | `string` | `"provisioned"` | no |
| <a name="input_engine_version"></a> [engine\_version](#input\_engine\_version) | The database engine version. Updating this argument results in an outage | `string` | `null` | no |
| <a name="input_final_snapshot_identifier"></a> [final\_snapshot\_identifier](#input\_final\_snapshot\_identifier) | The name of your final DB snapshot when this DB cluster is deleted. If omitted, no final snapshot will be made | `string` | `null` | no |
| <a name="input_global_cluster_identifier"></a> [global\_cluster\_identifier](#input\_global\_cluster\_identifier) | The global cluster identifier specified on `aws_rds_global_cluster` | `string` | `null` | no |
| <a name="input_iam_database_authentication_enabled"></a> [iam\_database\_authentication\_enabled](#input\_iam\_database\_authentication\_enabled) | Specifies whether or mappings of AWS Identity and Access Management (IAM) accounts to database accounts is enabled | `bool` | `null` | no |
| <a name="input_iam_role_description"></a> [iam\_role\_description](#input\_iam\_role\_description) | Description of the monitoring role | `string` | `null` | no |
| <a name="input_iam_role_max_session_duration"></a> [iam\_role\_max\_session\_duration](#input\_iam\_role\_max\_session\_duration) | Maximum session duration (in seconds) that you want to set for the monitoring role | `number` | `null` | no |
| <a name="input_iam_role_name"></a> [iam\_role\_name](#input\_iam\_role\_name) | Friendly name of the monitoring role | `string` | `null` | no |
| <a name="input_iam_role_path"></a> [iam\_role\_path](#input\_iam\_role\_path) | Path for the monitoring role | `string` | `null` | no |
| <a name="input_iam_role_permissions_boundary"></a> [iam\_role\_permissions\_boundary](#input\_iam\_role\_permissions\_boundary) | The ARN of the policy that is used to set the permissions boundary for the monitoring role | `string` | `null` | no |
| <a name="input_iam_role_use_name_prefix"></a> [iam\_role\_use\_name\_prefix](#input\_iam\_role\_use\_name\_prefix) | Determines whether to use `iam_role_name` as is or create a unique name beginning with the `iam_role_name` as the prefix | `bool` | `false` | no |
| <a name="input_instance_timeouts"></a> [instance\_timeouts](#input\_instance\_timeouts) | Create, update, and delete timeout configurations for the cluster instance(s) | <pre>object({<br/>    create = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_instances"></a> [instances](#input\_instances) | Map of cluster instances and any specific/overriding attributes to be created | <pre>map(object({<br/>    apply_immediately                     = optional(bool)<br/>    auto_minor_version_upgrade            = optional(bool)<br/>    availability_zone                     = optional(string)<br/>    ca_cert_identifier                    = optional(string)<br/>    copy_tags_to_snapshot                 = optional(bool, true)<br/>    custom_iam_instance_profile           = optional(string)<br/>    db_parameter_group_name               = optional(string)<br/>    db_subnet_group_name                  = optional(string)<br/>    identifier                            = optional(string)<br/>    identifier_prefix                     = optional(string)<br/>    instance_class                        = optional(string)<br/>    monitoring_interval                   = optional(number)<br/>    monitoring_role_arn                   = optional(string)<br/>    performance_insights_enabled          = optional(bool)<br/>    performance_insights_kms_key_id       = optional(string)<br/>    performance_insights_retention_period = optional(number)<br/>    preferred_maintenance_window          = optional(string)<br/>    promotion_tier                        = optional(number)<br/>    publicly_accessible                   = optional(bool)<br/>    tags                                  = optional(map(string), {})<br/>  }))</pre> | `{}` | no |
| <a name="input_instances_use_identifier_prefix"></a> [instances\_use\_identifier\_prefix](#input\_instances\_use\_identifier\_prefix) | Determines whether cluster instance identifiers are used as prefixes | `bool` | `false` | no |
| <a name="input_iops"></a> [iops](#input\_iops) | The amount of Provisioned IOPS (input/output operations per second) to be initially allocated for each DB instance in the Multi-AZ DB cluster | `number` | `null` | no |
| <a name="input_is_primary_cluster"></a> [is\_primary\_cluster](#input\_is\_primary\_cluster) | Determines whether cluster is primary cluster with writer instance (set to `false` for global cluster and replica clusters) | `bool` | `true` | no |
| <a name="input_kms_key_id"></a> [kms\_key\_id](#input\_kms\_key\_id) | The ARN for the KMS encryption key. When specifying `kms_key_id`, `storage_encrypted` needs to be set to `true` | `string` | `null` | no |
| <a name="input_manage_master_user_password"></a> [manage\_master\_user\_password](#input\_manage\_master\_user\_password) | Set to true to allow RDS to manage the master user password in Secrets Manager. Cannot be set if `master_password_wo` is provided | `bool` | `true` | no |
| <a name="input_manage_master_user_password_rotation"></a> [manage\_master\_user\_password\_rotation](#input\_manage\_master\_user\_password\_rotation) | Whether to manage the master user password rotation. By default, false on creation, rotation is managed by RDS. There is not currently a way to disable this on initial creation even when set to false. Setting this value to false after previously having been set to true will disable automatic rotation | `bool` | `false` | no |
| <a name="input_master_password_wo"></a> [master\_password\_wo](#input\_master\_password\_wo) | Write-Only required unless `manage_master_user_password` is set to `true`, a `snapshot_identifier`, `replication_source_identifier`, or unless a `global_cluster_identifier` is provided when the cluster is the "secondary" cluster of a global database) Password for the master DB user | `string` | `null` | no |
| <a name="input_master_password_wo_version"></a> [master\_password\_wo\_version](#input\_master\_password\_wo\_version) | Used together with `master_password_wo` to trigger an update. Increment this value when an update to the `master_password_wo` is required | `number` | `null` | no |
| <a name="input_master_user_password_rotate_immediately"></a> [master\_user\_password\_rotate\_immediately](#input\_master\_user\_password\_rotate\_immediately) | Specifies whether to rotate the secret immediately or wait until the next scheduled rotation window | `bool` | `null` | no |
| <a name="input_master_user_password_rotation_automatically_after_days"></a> [master\_user\_password\_rotation\_automatically\_after\_days](#input\_master\_user\_password\_rotation\_automatically\_after\_days) | Specifies the number of days between automatic scheduled rotations of the secret. Either `master_user_password_rotation_automatically_after_days` or `master_user_password_rotation_schedule_expression` must be specified | `number` | `null` | no |
| <a name="input_master_user_password_rotation_duration"></a> [master\_user\_password\_rotation\_duration](#input\_master\_user\_password\_rotation\_duration) | The length of the rotation window in hours. For example, 3h for a three hour window | `string` | `null` | no |
| <a name="input_master_user_password_rotation_schedule_expression"></a> [master\_user\_password\_rotation\_schedule\_expression](#input\_master\_user\_password\_rotation\_schedule\_expression) | A cron() or rate() expression that defines the schedule for rotating your secret. Either `master_user_password_rotation_automatically_after_days` or `master_user_password_rotation_schedule_expression` must be specified | `string` | `null` | no |
| <a name="input_master_user_secret_kms_key_id"></a> [master\_user\_secret\_kms\_key\_id](#input\_master\_user\_secret\_kms\_key\_id) | The Amazon Web Services KMS key identifier is the key ARN, key ID, alias ARN, or alias name for the KMS key | `string` | `null` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | Username for the master DB user. Required unless `snapshot_identifier` or `replication_source_identifier` is provided or unless a `global_cluster_identifier` is provided when the cluster is the secondary cluster of a global database | `string` | `null` | no |
| <a name="input_monitoring_role_arn"></a> [monitoring\_role\_arn](#input\_monitoring\_role\_arn) | IAM role used by RDS to send enhanced monitoring metrics to CloudWatch | `string` | `""` | no |
| <a name="input_name"></a> [name](#input\_name) | Name used across resources created | `string` | `""` | no |
| <a name="input_network_type"></a> [network\_type](#input\_network\_type) | The type of network stack to use (IPV4 or DUAL) | `string` | `null` | no |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections | `string` | `null` | no |
| <a name="input_predefined_metric_type"></a> [predefined\_metric\_type](#input\_predefined\_metric\_type) | The metric type to scale on. Valid values are `RDSReaderAverageCPUUtilization` and `RDSReaderAverageDatabaseConnections` | `string` | `"RDSReaderAverageCPUUtilization"` | no |
| <a name="input_preferred_backup_window"></a> [preferred\_backup\_window](#input\_preferred\_backup\_window) | Daily time range during which automated backups are created if automated backups are enabled using the BackupRetentionPeriod parameter.Time in UTC. Default: A 30-minute window selected at random from an 8-hour block of time per region, e.g. `04:00-09:00` | `string` | `null` | no |
| <a name="input_preferred_maintenance_window"></a> [preferred\_maintenance\_window](#input\_preferred\_maintenance\_window) | Weekly time range during which system maintenance can occur, in (UTC) e.g., `wed:04:00-wed:04:30` | `string` | `null` | no |
| <a name="input_putin_khuylo"></a> [putin\_khuylo](#input\_putin\_khuylo) | Do you agree that Putin doesn't respect Ukrainian sovereignty and territorial integrity? More info: https://en.wikipedia.org/wiki/Putin_khuylo! | `bool` | `true` | no |
| <a name="input_region"></a> [region](#input\_region) | Region where the resource(s) will be managed. Defaults to the Region set in the provider configuration | `string` | `null` | no |
| <a name="input_replication_source_identifier"></a> [replication\_source\_identifier](#input\_replication\_source\_identifier) | ARN of a source DB cluster or DB instance if this DB cluster is to be created as a Read Replica | `string` | `null` | no |
| <a name="input_restore_to_point_in_time"></a> [restore\_to\_point\_in\_time](#input\_restore\_to\_point\_in\_time) | Map of nested attributes for cloning Aurora cluster | <pre>object({<br/>    restore_to_time            = optional(string)<br/>    restore_type               = optional(string)<br/>    source_cluster_identifier  = optional(string)<br/>    source_cluster_resource_id = optional(string)<br/>    use_latest_restorable_time = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_role_associations"></a> [role\_associations](#input\_role\_associations) | Map of IAM roles and supported feature names to associate with the cluster | <pre>map(object({<br/>    feature_name = optional(string)<br/>    role_arn     = string<br/>  }))</pre> | `{}` | no |
| <a name="input_s3_import"></a> [s3\_import](#input\_s3\_import) | Configuration map used to restore from a Percona Xtrabackup in S3 (only MySQL is supported) | <pre>object({<br/>    bucket_name           = string<br/>    bucket_prefix         = optional(string)<br/>    ingestion_role        = string<br/>    source_engine_version = string<br/>  })</pre> | `null` | no |
| <a name="input_scaling_configuration"></a> [scaling\_configuration](#input\_scaling\_configuration) | Map of nested attributes with scaling properties. Only valid when `engine_mode` is set to `serverless` | <pre>object({<br/>    auto_pause               = optional(bool)<br/>    max_capacity             = optional(number)<br/>    min_capacity             = optional(number)<br/>    seconds_before_timeout   = optional(number)<br/>    seconds_until_auto_pause = optional(number)<br/>    timeout_action           = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | The description of the security group. If value is set to empty string it will contain cluster name in the description | `string` | `null` | no |
| <a name="input_security_group_egress_rules"></a> [security\_group\_egress\_rules](#input\_security\_group\_egress\_rules) | Map of security group egress rules to add to the security group created | <pre>map(object({<br/>    name = optional(string)<br/><br/>    cidr_ipv4                    = optional(string)<br/>    cidr_ipv6                    = optional(string)<br/>    description                  = optional(string)<br/>    from_port                    = optional(number)<br/>    ip_protocol                  = optional(string, "tcp")<br/>    prefix_list_id               = optional(string)<br/>    referenced_security_group_id = optional(string)<br/>    region                       = optional(string)<br/>    tags                         = optional(map(string), {})<br/>    to_port                      = optional(number)<br/>  }))</pre> | `{}` | no |
| <a name="input_security_group_ingress_rules"></a> [security\_group\_ingress\_rules](#input\_security\_group\_ingress\_rules) | Map of security group ingress rules to add to the security group created | <pre>map(object({<br/>    name = optional(string)<br/><br/>    cidr_ipv4                    = optional(string)<br/>    cidr_ipv6                    = optional(string)<br/>    description                  = optional(string)<br/>    from_port                    = optional(number)<br/>    ip_protocol                  = optional(string, "tcp")<br/>    prefix_list_id               = optional(string)<br/>    referenced_security_group_id = optional(string)<br/>    region                       = optional(string)<br/>    tags                         = optional(map(string), {})<br/>    to_port                      = optional(number)<br/>  }))</pre> | `{}` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | The security group name. Default value is (`var.name`) | `string` | `""` | no |
| <a name="input_security_group_tags"></a> [security\_group\_tags](#input\_security\_group\_tags) | Additional tags for the security group | `map(string)` | `{}` | no |
| <a name="input_security_group_use_name_prefix"></a> [security\_group\_use\_name\_prefix](#input\_security\_group\_use\_name\_prefix) | Determines whether the security group name (`var.name`) is used as a prefix | `bool` | `true` | no |
| <a name="input_serverlessv2_scaling_configuration"></a> [serverlessv2\_scaling\_configuration](#input\_serverlessv2\_scaling\_configuration) | Map of nested attributes with serverless v2 scaling properties. Only valid when `engine_mode` is set to `provisioned` | <pre>object({<br/>    max_capacity             = number<br/>    min_capacity             = optional(number)<br/>    seconds_until_auto_pause = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_shard_group"></a> [shard\_group](#input\_shard\_group) | Arguments for the DB shard group to be created | <pre>object({<br/>    compute_redundancy  = optional(number)<br/>    identifier          = string<br/>    max_acu             = number<br/>    min_acu             = optional(number)<br/>    publicly_accessible = optional(bool)<br/>    tags                = optional(map(string), {})<br/>    timeouts = optional(object({<br/>      create = optional(string)<br/>      update = optional(string)<br/>      delete = optional(string)<br/>    }))<br/>  })</pre> | `null` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | Determines whether a final snapshot is created before the cluster is deleted. If true is specified, no snapshot is created | `bool` | `false` | no |
| <a name="input_snapshot_identifier"></a> [snapshot\_identifier](#input\_snapshot\_identifier) | Specifies whether or not to create this cluster from a snapshot. You can use either the name or ARN when specifying a DB cluster snapshot, or the ARN when specifying a DB snapshot | `string` | `null` | no |
| <a name="input_source_region"></a> [source\_region](#input\_source\_region) | The source region for an encrypted replica DB cluster | `string` | `null` | no |
| <a name="input_storage_encrypted"></a> [storage\_encrypted](#input\_storage\_encrypted) | Specifies whether the DB cluster is encrypted. The default is `true` | `bool` | `true` | no |
| <a name="input_storage_type"></a> [storage\_type](#input\_storage\_type) | Determines the storage type for the DB cluster. Optional for Single-AZ, required for Multi-AZ DB clusters. Valid values for Single-AZ: `aurora`, `""` (default, both refer to Aurora Standard), `aurora-iopt1` (Aurora I/O Optimized). Valid values for Multi-AZ: `io1` (default) | `string` | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnet IDs used by database subnet group created | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where to create security group | `string` | `""` | no |
| <a name="input_vpc_security_group_ids"></a> [vpc\_security\_group\_ids](#input\_vpc\_security\_group\_ids) | List of VPC security groups to associate to the cluster in addition to the security group created | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_additional_cluster_endpoints"></a> [additional\_cluster\_endpoints](#output\_additional\_cluster\_endpoints) | A map of additional cluster endpoints and their attributes |
| <a name="output_cluster_arn"></a> [cluster\_arn](#output\_cluster\_arn) | Amazon Resource Name (ARN) of cluster |
| <a name="output_cluster_ca_certificate_identifier"></a> [cluster\_ca\_certificate\_identifier](#output\_cluster\_ca\_certificate\_identifier) | CA identifier of the CA certificate used for the DB instance's server certificate |
| <a name="output_cluster_ca_certificate_valid_till"></a> [cluster\_ca\_certificate\_valid\_till](#output\_cluster\_ca\_certificate\_valid\_till) | Expiration date of the DB instance’s server certificate |
| <a name="output_cluster_database_name"></a> [cluster\_database\_name](#output\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_cluster_endpoint"></a> [cluster\_endpoint](#output\_cluster\_endpoint) | Writer endpoint for the cluster |
| <a name="output_cluster_engine_version_actual"></a> [cluster\_engine\_version\_actual](#output\_cluster\_engine\_version\_actual) | The running version of the cluster database |
| <a name="output_cluster_hosted_zone_id"></a> [cluster\_hosted\_zone\_id](#output\_cluster\_hosted\_zone\_id) | The Route53 Hosted Zone ID of the endpoint |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The RDS Cluster Identifier |
| <a name="output_cluster_instances"></a> [cluster\_instances](#output\_cluster\_instances) | A map of cluster instances and their attributes |
| <a name="output_cluster_master_user_secret"></a> [cluster\_master\_user\_secret](#output\_cluster\_master\_user\_secret) | The generated database master user secret when `manage_master_user_password` is set to `true` |
| <a name="output_cluster_master_username"></a> [cluster\_master\_username](#output\_cluster\_master\_username) | The database master username |
| <a name="output_cluster_members"></a> [cluster\_members](#output\_cluster\_members) | List of RDS Instances that are a part of this cluster |
| <a name="output_cluster_port"></a> [cluster\_port](#output\_cluster\_port) | The database port |
| <a name="output_cluster_reader_endpoint"></a> [cluster\_reader\_endpoint](#output\_cluster\_reader\_endpoint) | A read-only endpoint for the cluster, automatically load-balanced across replicas |
| <a name="output_cluster_resource_id"></a> [cluster\_resource\_id](#output\_cluster\_resource\_id) | The RDS Cluster Resource ID |
| <a name="output_cluster_role_associations"></a> [cluster\_role\_associations](#output\_cluster\_role\_associations) | A map of IAM roles associated with the cluster and their attributes |
| <a name="output_cluster_upgrade_rollout_order"></a> [cluster\_upgrade\_rollout\_order](#output\_cluster\_upgrade\_rollout\_order) | Order in which the clusters are upgraded (first, second, last) |
| <a name="output_db_cluster_activity_stream_kinesis_stream_name"></a> [db\_cluster\_activity\_stream\_kinesis\_stream\_name](#output\_db\_cluster\_activity\_stream\_kinesis\_stream\_name) | The name of the Amazon Kinesis data stream to be used for the database activity stream |
| <a name="output_db_cluster_cloudwatch_log_groups"></a> [db\_cluster\_cloudwatch\_log\_groups](#output\_db\_cluster\_cloudwatch\_log\_groups) | Map of CloudWatch log groups created and their attributes |
| <a name="output_db_cluster_parameter_group_arn"></a> [db\_cluster\_parameter\_group\_arn](#output\_db\_cluster\_parameter\_group\_arn) | The ARN of the DB cluster parameter group created |
| <a name="output_db_cluster_parameter_group_id"></a> [db\_cluster\_parameter\_group\_id](#output\_db\_cluster\_parameter\_group\_id) | The ID of the DB cluster parameter group created |
| <a name="output_db_cluster_secretsmanager_secret_rotation_enabled"></a> [db\_cluster\_secretsmanager\_secret\_rotation\_enabled](#output\_db\_cluster\_secretsmanager\_secret\_rotation\_enabled) | Specifies whether automatic rotation is enabled for the secret |
| <a name="output_db_parameter_group_arn"></a> [db\_parameter\_group\_arn](#output\_db\_parameter\_group\_arn) | The ARN of the DB parameter group created |
| <a name="output_db_parameter_group_id"></a> [db\_parameter\_group\_id](#output\_db\_parameter\_group\_id) | The ID of the DB parameter group created |
| <a name="output_db_shard_group_arn"></a> [db\_shard\_group\_arn](#output\_db\_shard\_group\_arn) | ARN of the shard group |
| <a name="output_db_shard_group_endpoint"></a> [db\_shard\_group\_endpoint](#output\_db\_shard\_group\_endpoint) | The connection endpoint for the DB shard group |
| <a name="output_db_shard_group_resource_id"></a> [db\_shard\_group\_resource\_id](#output\_db\_shard\_group\_resource\_id) | The AWS Region-unique, immutable identifier for the DB shard group |
| <a name="output_db_subnet_group_name"></a> [db\_subnet\_group\_name](#output\_db\_subnet\_group\_name) | The db subnet group name |
| <a name="output_enhanced_monitoring_iam_role_arn"></a> [enhanced\_monitoring\_iam\_role\_arn](#output\_enhanced\_monitoring\_iam\_role\_arn) | The Amazon Resource Name (ARN) specifying the enhanced monitoring role |
| <a name="output_enhanced_monitoring_iam_role_name"></a> [enhanced\_monitoring\_iam\_role\_name](#output\_enhanced\_monitoring\_iam\_role\_name) | The name of the enhanced monitoring role |
| <a name="output_enhanced_monitoring_iam_role_unique_id"></a> [enhanced\_monitoring\_iam\_role\_unique\_id](#output\_enhanced\_monitoring\_iam\_role\_unique\_id) | Stable and unique string identifying the enhanced monitoring role |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The security group ID of the cluster |
<!-- END_TF_DOCS -->

## Authors

Module is maintained by [Anton Babenko](https://github.com/antonbabenko) with help from [these awesome contributors](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/graphs/contributors).

## License

Apache 2 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/tree/master/LICENSE) for full details.

## Additional information for users from Russia and Belarus

* Russia has [illegally annexed Crimea in 2014](https://en.wikipedia.org/wiki/Annexation_of_Crimea_by_the_Russian_Federation) and [brought the war in Donbas](https://en.wikipedia.org/wiki/War_in_Donbas) followed by [full-scale invasion of Ukraine in 2022](https://en.wikipedia.org/wiki/2022_Russian_invasion_of_Ukraine).
* Russia has brought sorrow and devastations to millions of Ukrainians, killed hundreds of innocent people, damaged thousands of buildings, and forced several million people to flee.
* [Putin khuylo!](https://en.wikipedia.org/wiki/Putin_khuylo!)
