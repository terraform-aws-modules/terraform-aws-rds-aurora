# Aurora DSQL Cluster Example

Configuration in this directory creates multi-region peered Aurora DSQL clusters and a single region Aurora DSQL cluster.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.100 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dsql_cluster_1"></a> [dsql\_cluster\_1](#module\_dsql\_cluster\_1) | ../../modules/dsql | n/a |
| <a name="module_dsql_cluster_2"></a> [dsql\_cluster\_2](#module\_dsql\_cluster\_2) | ../../modules/dsql | n/a |
| <a name="module_dsql_single_region"></a> [dsql\_single\_region](#module\_dsql\_single\_region) | ../../modules/dsql | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dsql_cluster_1_arn"></a> [dsql\_cluster\_1\_arn](#output\_dsql\_cluster\_1\_arn) | ARN of the cluster |
| <a name="output_dsql_cluster_1_encryption_details"></a> [dsql\_cluster\_1\_encryption\_details](#output\_dsql\_cluster\_1\_encryption\_details) | Encryption configuration details for the DSQL cluster |
| <a name="output_dsql_cluster_1_identifier"></a> [dsql\_cluster\_1\_identifier](#output\_dsql\_cluster\_1\_identifier) | Cluster identifier |
| <a name="output_dsql_cluster_1_multi_region_properties"></a> [dsql\_cluster\_1\_multi\_region\_properties](#output\_dsql\_cluster\_1\_multi\_region\_properties) | Multi-region properties of the DSQL cluster |
| <a name="output_dsql_cluster_1_vpc_endpoint_service_name"></a> [dsql\_cluster\_1\_vpc\_endpoint\_service\_name](#output\_dsql\_cluster\_1\_vpc\_endpoint\_service\_name) | The DSQL cluster's VPC endpoint service name |
| <a name="output_dsql_cluster_2_arn"></a> [dsql\_cluster\_2\_arn](#output\_dsql\_cluster\_2\_arn) | ARN of the cluster |
| <a name="output_dsql_cluster_2_encryption_details"></a> [dsql\_cluster\_2\_encryption\_details](#output\_dsql\_cluster\_2\_encryption\_details) | Encryption configuration details for the DSQL cluster |
| <a name="output_dsql_cluster_2_identifier"></a> [dsql\_cluster\_2\_identifier](#output\_dsql\_cluster\_2\_identifier) | Cluster identifier |
| <a name="output_dsql_cluster_2_multi_region_properties"></a> [dsql\_cluster\_2\_multi\_region\_properties](#output\_dsql\_cluster\_2\_multi\_region\_properties) | Multi-region properties of the DSQL cluster |
| <a name="output_dsql_cluster_2_vpc_endpoint_service_name"></a> [dsql\_cluster\_2\_vpc\_endpoint\_service\_name](#output\_dsql\_cluster\_2\_vpc\_endpoint\_service\_name) | The DSQL cluster's VPC endpoint service name |
<!-- END_TF_DOCS -->
