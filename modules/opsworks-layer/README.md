
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| assign_elastic_ips | Enable auto assign elastic ips | string | `false` | no |
| assign_public_ips | Enable auto assign public ips | string | `false` | no |
| custom_configure_recipes | The custom configure recipes for the OpsWorks layer | list | `<list>` | no |
| custom_deploy_recipes | The custom deploy recipes for the OpsWorks layer | list | `<list>` | no |
| custom_json | The custom json for the OpsWorks layer | string | - | yes |
| custom_setup_recipes | The custom setup recipes for the OpsWorks layer | list | `<list>` | no |
| custom_shutdown_recipes | The custom shutdown recipes for the OpsWorks layer | list | `<list>` | no |
| custom_undeploy_recipes | The custom undeploy recipes for the OpsWorks layer | list | `<list>` | no |
| drain_elb | Enable connection draining on ELB | string | `true` | no |
| enabled |  | string | `1` | no |
| iam_instance_profile | The IAM role the instance should assume | string | - | yes |
| image_id | The AMI Id for the launch configuration | string | - | yes |
| instance_shutdown_timeout | The time in seconds that OpsWorks will wait for Chef after triggering shutdown | string | `120` | no |
| instance_type | The AWS instance type the service should be created with i.e. c5.large | string | - | yes |
| key_name | Key name for Launch config | string | `` | no |
| logging_volume_size | Defaults to 20 GB | string | `20` | no |
| max_size | ASG max instance count | string | `1` | no |
| min_size | ASG min instance count | string | `1` | no |
| name | The name for the OpsWorks layer | string | - | yes |
| security_groups | A list of security group IDs to trust | list | - | yes |
| short_name | The short name for the OpsWorks layer | string | - | yes |
| stack_id | The stack id for the OpsWorks layer | string | - | yes |
| stack_name | Name of stack the ASG layer belongs to | string | - | yes |
| subnets | List of subnets for ASG | list | - | yes |
| use_ebs | Enable ebs optimized instances | string | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| id |  |
| name |  |

