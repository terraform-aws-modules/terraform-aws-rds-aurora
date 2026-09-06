# AWS RDS Aurora DSQL Terraform module

Terraform sub-module which creates DSQL resources.

## Usage

See [DSQL](https://github.com/terraform-aws-modules/terraform-aws-rds-aurora/tree/master/examples/dsql) directory for working examples to reference:

```hcl
module "dsql_cluster_1" {
  source = "../../modules/dsql"

  name = "dsql-1"

  witness_region              = "us-east-2"
  create_cluster_peering      = true
  clusters                    = [module.dsql_cluster_2.arn]

  tags = {
    Environment = "production"
   }
}

module "dsql_cluster_2" {
  source = "../../modules/dsql"

  region = "us-east-2"

  name = "dsql-2"

  witness_region              = "us-west-2"
  create_cluster_peering      = true
  clusters                    = [module.dsql_cluster_1.arn]

  tags = {
    Environment = "production"
   }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
| ---- | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.11.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.61 |

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.61 |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [aws_dsql_cluster.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dsql_cluster) | resource |
| [aws_dsql_cluster_peering.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dsql_cluster_peering) | resource |
| [aws_dsql_cluster_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dsql_cluster_policy) | resource |
| [aws_iam_policy_document.dsql_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_cluster_policy"></a> [cluster\_policy](#input\_cluster\_policy) | The Aurora DSQL cluster resource-based policy document as a JSON string. Ignored if cluster\_policy\_statements, cluster\_policy\_source\_policy\_documents, or cluster\_policy\_override\_policy\_documents are set. | `string` | `null` | no |
| <a name="input_cluster_policy_bypass_lockout_safety_check"></a> [cluster\_policy\_bypass\_lockout\_safety\_check](#input\_cluster\_policy\_bypass\_lockout\_safety\_check) | Whether to bypass the policy lockout safety check when applying the policy. Use with caution, as the policy may lock you out of the cluster | `bool` | `null` | no |
| <a name="input_cluster_policy_override_policy_documents"></a> [cluster\_policy\_override\_policy\_documents](#input\_cluster\_policy\_override\_policy\_documents) | List of policy documents to override the DSQL cluster resource-based policy. These policies completely replace the inline policy. | `list(string)` | `[]` | no |
| <a name="input_cluster_policy_source_policy_documents"></a> [cluster\_policy\_source\_policy\_documents](#input\_cluster\_policy\_source\_policy\_documents) | List of policy documents to include in the DSQL cluster resource-based policy. Merged with the inline policy. | `list(string)` | `[]` | no |
| <a name="input_cluster_policy_statements"></a> [cluster\_policy\_statements](#input\_cluster\_policy\_statements) | List of IAM policy statement objects to include in the DSQL cluster resource-based policy. Each statement should have: sid, actions, effect, principals, not\_principals, resources, conditions. | <pre>list(object({<br/>    sid       = optional(string)<br/>    effect    = optional(string)<br/>    actions   = optional(list(string))<br/>    resources = optional(list(string))<br/>    principals = optional(list(object({<br/>      type        = string<br/>      identifiers = list(string)<br/>    })))<br/>    conditions = optional(list(object({<br/>      test     = string<br/>      variable = string<br/>      values   = list(string)<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_cluster_policy_timeouts"></a> [cluster\_policy\_timeouts](#input\_cluster\_policy\_timeouts) | Timeout configuration for the DSQL cluster resource-based policy | <pre>object({<br/>    create = optional(string)<br/>    update = optional(string)<br/>    delete = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_clusters"></a> [clusters](#input\_clusters) | List of DSQL Cluster ARNs to be peered to this cluster | `list(string)` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether cluster should be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_cluster_peering"></a> [create\_cluster\_peering](#input\_create\_cluster\_peering) | Whether to create cluster peering | `bool` | `false` | no |
| <a name="input_create_cluster_policy"></a> [create\_cluster\_policy](#input\_create\_cluster\_policy) | Whether to create the DSQL cluster resource-based policy | `bool` | `false` | no |
| <a name="input_deletion_protection_enabled"></a> [deletion\_protection\_enabled](#input\_deletion\_protection\_enabled) | Whether deletion protection is enabled in this cluster | `bool` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Destroys cluster even if deletion\_protection\_enabled is set to true. Default value is false | `bool` | `null` | no |
| <a name="input_kms_encryption_key"></a> [kms\_encryption\_key](#input\_kms\_encryption\_key) | The ARN of the AWS KMS key that encrypts data in the DSQL Cluster, or `AWS_OWNED_KMS_KEY` | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name used across resources created | `string` | `""` | no |
| <a name="input_region"></a> [region](#input\_region) | Region where the resource(s) will be managed. Defaults to the Region set in the provider configuration | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_timeouts"></a> [timeouts](#input\_timeouts) | Timeout configuration for the cluster | <pre>object({<br/>    create = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_witness_region"></a> [witness\_region](#input\_witness\_region) | Witness region for the multi-region clusters. Setting this makes this cluster a multi-region cluster. Changing it recreates the cluster | `string` | `null` | no |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the cluster |
| <a name="output_cluster_policy"></a> [cluster\_policy](#output\_cluster\_policy) | The Aurora DSQL cluster resource-based policy document |
| <a name="output_cluster_policy_version"></a> [cluster\_policy\_version](#output\_cluster\_policy\_version) | The version of the Aurora DSQL cluster resource-based policy document |
| <a name="output_encryption_details"></a> [encryption\_details](#output\_encryption\_details) | Encryption configuration details for the DSQL cluster |
| <a name="output_identifier"></a> [identifier](#output\_identifier) | Cluster identifier |
| <a name="output_multi_region_properties"></a> [multi\_region\_properties](#output\_multi\_region\_properties) | Multi-region properties of the DSQL cluster |
| <a name="output_vpc_endpoint_service_name"></a> [vpc\_endpoint\_service\_name](#output\_vpc\_endpoint\_service\_name) | The DSQL cluster's VPC endpoint service name |
<!-- END_TF_DOCS -->
