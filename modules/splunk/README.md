
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws_account_name | Name of aws account | string | - | yes |
| cloudtrail_name | Cloudtrail name that be configured for splunk | string | - | yes |
| config_delivery_frequency | The frequency with which AWS Config delivers configuration snapshots. | string | `Six_Hours` | no |
| config_max_execution_frequency | The maximum frequency with which AWS Config runs evaluations for a rule. | string | `TwentyFour_Hours` | no |
| config_name | Config name that be configured for splunk. Default config name is default | string | - | yes |
| region | AWS Region | string | `us-east-1` | no |
| vpc_ids | List of VPCs ID that you want flow log enabled for. | list | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| s3_cf_path |  |
| s3_domain_name |  |
| s3_elbaccess_path |  |
| s3_log_bucket_id | Bucket used for logging |
| s3_s3access_path |  |

