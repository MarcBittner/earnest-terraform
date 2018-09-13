
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| engine_version |  | string | `3.2.10` | no |
| environment | dev, qa, prod, etc | string | - | yes |
| maintenance_window |  | string | `sun:01:00-sun:03:00` | no |
| name | The name of the ElasticCache redis cluster | string | - | yes |
| node_count |  | string | `1` | no |
| node_type |  | string | `cache.m3.medium` | no |
| number_of_shards |  | string | `3` | no |
| parameter_group_name |  | string | `default.redis3.2.cluster.on` | no |
| qualsys_sg_id | The Qualsys security group ID | string | - | yes |
| replicas_per_shard |  | string | `2` | no |
| snapshot_retention_limit |  | string | `1` | no |
| snapshot_window |  | string | `03:00-04:00` | no |
| subnet_group_name |  | string | - | yes |
| vpc_id | The VPC ID to launch the cluster in | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| redis_endpoint |  |
| security_group_id |  |

