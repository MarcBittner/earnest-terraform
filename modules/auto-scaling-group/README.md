
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| desired_count | ASG desired instance count | string | `1` | no |
| environment | The environment the ASG is in | string | - | yes |
| health_check_type | Either ELB or EC2 | string | `EC2` | no |
| healthcheck_grace_period | Time it takes after instance spins up before checking health | string | `180` | no |
| iam_instance_profile | The IAM role the instance should assume | string | - | yes |
| image_id | The AMI Id for the launch configuration | string | - | yes |
| instance_type | The AWS instance type the service should be created with i.e. c5.large | string | - | yes |
| load_balancer_name | Name of load balancer to assign to the ASG | string | `` | no |
| max_size | ASG max instance count | string | `1` | no |
| min_size | ASG min instance count | string | `1` | no |
| name | The project name | string | - | yes |
| security_groups | The IDs of the security groups to attach to the ASG launch configuration | list | `<list>` | no |
| ssh_key_name | The ssh key name for the private key to ssh into ASG instances | string | `` | no |
| subnets | List of subnets for ASG | list | - | yes |
| user_data | The user data for the launch configuration | string | - | yes |
| wait_for_capacity_timeout | Time it takes to timeout if ASG does not pass healthcheck | string | `10m` | no |
| wait_for_elb_capacity | The desired instances that passes the ELB healthcheck (on creation and updates of ASG) | string | `1` | no |

## Outputs

| Name | Description |
|------|-------------|
| asg_name |  |

