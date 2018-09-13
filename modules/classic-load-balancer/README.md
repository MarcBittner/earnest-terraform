
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| connection_draining |  | string | `true` | no |
| connection_draining_timeout |  | string | `400` | no |
| environment |  | string | - | yes |
| healthy_threshold |  | string | `10` | no |
| idle_timeout |  | string | `400` | no |
| interval |  | string | `30` | no |
| is_internal_load_balancer |  | string | `true` | no |
| listeners |  | list | - | yes |
| logging_bucket | The S3 bucket to send access logs to | string | `ring-it-elb-logs` | no |
| name |  | string | - | yes |
| region |  | string | - | yes |
| security_groups |  | list | - | yes |
| subnets |  | list | - | yes |
| target |  | string | - | yes |
| timeout |  | string | `5` | no |
| unhealthy_threshold |  | string | `2` | no |

## Outputs

| Name | Description |
|------|-------------|
| dns_name |  |
| name |  |
| zone_id |  |

