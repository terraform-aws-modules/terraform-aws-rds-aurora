# DSQL Cluster

Terraform sub-module which creates DSQL cluster and peering resources.

## Usage

See [DSQL](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/tree/master/examples/dsql) directory for working examples to reference:

```hcl
module "dsql_cluster_1" {
  source = "../../modules/dsql"

  witness_region              = "us-west-2"
  create_cluster_peering      = true
  clusters                    = [module.dsql_cluster_2.arn]

  tags = { Name = "dsql-1" }
}

module "dsql_cluster_2" {
  source = "../../modules/dsql"

  witness_region              = "us-west-2"
  create_cluster_peering      = true
  clusters                    = [module.dsql_cluster_1.arn]

  tags = { Name = "dsql-2" }

  providers = {
    aws = aws.region2
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.100 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.100 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dsql_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dsql_cluster) | resource |
| [aws_dsql_cluster_peering.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dsql_cluster_peering) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clusters"></a> [clusters](#input\_clusters) | List of DSQL Cluster ARNs to be peered to this cluster | `list(string)` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether cluster should be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_cluster_peering"></a> [create\_cluster\_peering](#input\_create\_cluster\_peering) | Whether to create cluster peering | `bool` | `false` | no |
| <a name="input_deletion_protection_enabled"></a> [deletion\_protection\_enabled](#input\_deletion\_protection\_enabled) | Whether deletion protection is enabled in this cluster | `bool` | `null` | no |
| <a name="input_kms_encryption_key"></a> [kms\_encryption\_key](#input\_kms\_encryption\_key) | The ARN of the AWS KMS key that encrypts data in the DSQL Cluster, or `AWS_OWNED_KMS_KEY` | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to be associated with the AWS DSQL Cluster resource | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Create timeout configuration for the cluster | `any` | `{}` | no |
| <a name="input_witness_region"></a> [witness\_region](#input\_witness\_region) | Witness region for the multi-region clusters. Setting this makes this cluster a multi-region cluster. Changing it recreates the cluster | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the cluster |
| <a name="output_encryption_details"></a> [encryption\_details](#output\_encryption\_details) | Encryption configuration details for the DSQL cluster |
| <a name="output_identifier"></a> [identifier](#output\_identifier) | Cluster identifier |
| <a name="output_multi_region_properties"></a> [multi\_region\_properties](#output\_multi\_region\_properties) | Multi-region properties of the DSQL cluster |
| <a name="output_vpc_endpoint_service_name"></a> [vpc\_endpoint\_service\_name](#output\_vpc\_endpoint\_service\_name) | The DSQL cluster's VPC endpoint service name |
<!-- END_TF_DOCS -->
