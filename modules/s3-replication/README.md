<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.60 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.60 |
| <a name="provider_aws.destination"></a> [aws.destination](#provider\_aws.destination) | >= 5.60 |
| <a name="provider_aws.source"></a> [aws.source](#provider\_aws.source) | >= 5.60 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.replication_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.replication_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.replication_role_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_s3_bucket_replication_configuration.replication](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_replication_configuration) | resource |
| [aws_iam_policy_document.replication_policy_document](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.s3_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_destination_bucket_name"></a> [destination\_bucket\_name](#input\_destination\_bucket\_name) | n/a | `string` | `"Name of the destination bucket."` | no |
| <a name="input_filter_prefix"></a> [filter\_prefix](#input\_filter\_prefix) | Optional prefix to filter replication. | `string` | `""` | no |
| <a name="input_replicate_delete_markers"></a> [replicate\_delete\_markers](#input\_replicate\_delete\_markers) | Whether delete markers are replicated. | `bool` | `true` | no |
| <a name="input_source_bucket_name"></a> [source\_bucket\_name](#input\_source\_bucket\_name) | Name of the source bucket. | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->