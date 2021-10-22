# PostgreSQL Example

Configuration in this directory creates a PostgreSQL Aurora cluster.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.63 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.63 |
| <a name="provider_aws.secondary"></a> [aws.secondary](#provider\_aws.secondary) | >= 3.63 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_primary_aurora"></a> [primary\_aurora](#module\_primary\_aurora) | ../../ | n/a |
| <a name="module_primary_vpc"></a> [primary\_vpc](#module\_primary\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |
| <a name="module_secondary_aurora"></a> [secondary\_aurora](#module\_secondary\_aurora) | ../../ | n/a |
| <a name="module_secondary_vpc"></a> [secondary\_vpc](#module\_secondary\_vpc) | terraform-aws-modules/vpc/aws | ~> 3.0 |

## Resources

| Name | Type |
|------|------|
| [aws_kms_key.primary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_kms_key.secondary](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key) | resource |
| [aws_rds_global_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_global_cluster) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_global_cluster_members"></a> [global\_cluster\_members](#output\_global\_cluster\_members) | Set of objects containing Global Cluster members |
| <a name="output_primary_cluster_database_name"></a> [primary\_cluster\_database\_name](#output\_primary\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_primary_cluster_endpoint"></a> [primary\_cluster\_endpoint](#output\_primary\_cluster\_endpoint) | The cluster endpoint |
| <a name="output_primary_cluster_id"></a> [primary\_cluster\_id](#output\_primary\_cluster\_id) | The ID of the cluster |
| <a name="output_primary_cluster_instance_dbi_resource_ids"></a> [primary\_cluster\_instance\_dbi\_resource\_ids](#output\_primary\_cluster\_instance\_dbi\_resource\_ids) | A list of all the region-unique, immutable identifiers for the DB instances |
| <a name="output_primary_cluster_instance_endpoints"></a> [primary\_cluster\_instance\_endpoints](#output\_primary\_cluster\_instance\_endpoints) | A list of all cluster instance endpoints |
| <a name="output_primary_cluster_instance_ids"></a> [primary\_cluster\_instance\_ids](#output\_primary\_cluster\_instance\_ids) | A list of all cluster instance ids |
| <a name="output_primary_cluster_master_password"></a> [primary\_cluster\_master\_password](#output\_primary\_cluster\_master\_password) | The master password |
| <a name="output_primary_cluster_master_username"></a> [primary\_cluster\_master\_username](#output\_primary\_cluster\_master\_username) | The master username |
| <a name="output_primary_cluster_port"></a> [primary\_cluster\_port](#output\_primary\_cluster\_port) | The port |
| <a name="output_primary_cluster_reader_endpoint"></a> [primary\_cluster\_reader\_endpoint](#output\_primary\_cluster\_reader\_endpoint) | The cluster reader endpoint |
| <a name="output_primary_cluster_resource_id"></a> [primary\_cluster\_resource\_id](#output\_primary\_cluster\_resource\_id) | The Resource ID of the cluster |
| <a name="output_primary_security_group_id"></a> [primary\_security\_group\_id](#output\_primary\_security\_group\_id) | The security group ID of the cluster |
| <a name="output_secondary_cluster_database_name"></a> [secondary\_cluster\_database\_name](#output\_secondary\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_secondary_cluster_endpoint"></a> [secondary\_cluster\_endpoint](#output\_secondary\_cluster\_endpoint) | The cluster endpoint |
| <a name="output_secondary_cluster_id"></a> [secondary\_cluster\_id](#output\_secondary\_cluster\_id) | The ID of the cluster |
| <a name="output_secondary_cluster_instance_dbi_resource_ids"></a> [secondary\_cluster\_instance\_dbi\_resource\_ids](#output\_secondary\_cluster\_instance\_dbi\_resource\_ids) | A list of all the region-unique, immutable identifiers for the DB instances |
| <a name="output_secondary_cluster_instance_endpoints"></a> [secondary\_cluster\_instance\_endpoints](#output\_secondary\_cluster\_instance\_endpoints) | A list of all cluster instance endpoints |
| <a name="output_secondary_cluster_instance_ids"></a> [secondary\_cluster\_instance\_ids](#output\_secondary\_cluster\_instance\_ids) | A list of all cluster instance ids |
| <a name="output_secondary_cluster_master_password"></a> [secondary\_cluster\_master\_password](#output\_secondary\_cluster\_master\_password) | The master password |
| <a name="output_secondary_cluster_master_username"></a> [secondary\_cluster\_master\_username](#output\_secondary\_cluster\_master\_username) | The master username |
| <a name="output_secondary_cluster_port"></a> [secondary\_cluster\_port](#output\_secondary\_cluster\_port) | The port |
| <a name="output_secondary_cluster_reader_endpoint"></a> [secondary\_cluster\_reader\_endpoint](#output\_secondary\_cluster\_reader\_endpoint) | The cluster reader endpoint |
| <a name="output_secondary_cluster_resource_id"></a> [secondary\_cluster\_resource\_id](#output\_secondary\_cluster\_resource\_id) | The Resource ID of the cluster |
| <a name="output_secondary_security_group_id"></a> [secondary\_security\_group\_id](#output\_secondary\_security\_group\_id) | The security group ID of the cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
