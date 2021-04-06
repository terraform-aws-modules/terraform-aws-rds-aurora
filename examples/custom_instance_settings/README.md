# Custom Instance Settings Example

Configuration in this directory creates an Aurora cluster with multiple replicas configured through custom settings.

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
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.8 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.8 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_aurora"></a> [aurora](#module\_aurora) | ../../ |  |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 2 |

## Resources

| Name | Type |
|------|------|
| [aws_db_parameter_group.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_parameter_group) | resource |
| [aws_rds_cluster_parameter_group.example](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/rds_cluster_parameter_group) | resource |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_this_rds_cluster_database_name"></a> [this\_rds\_cluster\_database\_name](#output\_this\_rds\_cluster\_database\_name) | Name for an automatically created database on cluster creation |
| <a name="output_this_rds_cluster_endpoint"></a> [this\_rds\_cluster\_endpoint](#output\_this\_rds\_cluster\_endpoint) | The cluster endpoint |
| <a name="output_this_rds_cluster_id"></a> [this\_rds\_cluster\_id](#output\_this\_rds\_cluster\_id) | The ID of the cluster |
| <a name="output_this_rds_cluster_instance_endpoints"></a> [this\_rds\_cluster\_instance\_endpoints](#output\_this\_rds\_cluster\_instance\_endpoints) | A list of all cluster instance endpoints |
| <a name="output_this_rds_cluster_master_password"></a> [this\_rds\_cluster\_master\_password](#output\_this\_rds\_cluster\_master\_password) | The master password |
| <a name="output_this_rds_cluster_master_username"></a> [this\_rds\_cluster\_master\_username](#output\_this\_rds\_cluster\_master\_username) | The master username |
| <a name="output_this_rds_cluster_port"></a> [this\_rds\_cluster\_port](#output\_this\_rds\_cluster\_port) | The port |
| <a name="output_this_rds_cluster_reader_endpoint"></a> [this\_rds\_cluster\_reader\_endpoint](#output\_this\_rds\_cluster\_reader\_endpoint) | The cluster reader endpoint |
| <a name="output_this_rds_cluster_resource_id"></a> [this\_rds\_cluster\_resource\_id](#output\_this\_rds\_cluster\_resource\_id) | The Resource ID of the cluster |
| <a name="output_this_security_group_id"></a> [this\_security\_group\_id](#output\_this\_security\_group\_id) | The security group ID of the cluster |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
