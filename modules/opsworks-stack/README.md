
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| chef_version | The version of Chef the service is deployed with | string | - | yes |
| cookbooks_revision | The cookbooks branch being used i.e. master | string | - | yes |
| cookbooks_url | The cookbooks repository url | string | - | yes |
| default_subnet_id | The default subnet id | string | - | yes |
| environment | The environment i.e. dev, qa, prod | string | - | yes |
| full_name | The full name of the service | string | - | yes |
| region | The region the stack is in | string | - | yes |
| stack_name | The name of the stack | string | - | yes |
| vpc_id | The VPC id | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| default_instance_profile |  |
| stack_id |  |
| stack_name |  |

