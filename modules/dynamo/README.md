
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| additional_attributes | List of additional table attributes and their types | list | `<list>` | no |
| enable_backups | Whether backup is enabled | string | `true` | no |
| enable_encryption | Whether encryption is enabled | string | `false` | no |
| environment | The current environment i.e. dev, qa, prod, etc | string | - | yes |
| global_secondary_indexes | List of global secondary indexes | list | `<list>` | no |
| hash_key | The partition key that is used to partition data | string | - | yes |
| hash_key_type | The type of the partition key (S, N, or B) | string | `S` | no |
| local_secondary_indexes | List of local secondary indexes | list | `<list>` | no |
| name | The name of the dynamo db table | string | - | yes |
| range_key | The sort key used for searching within a partition | string | - | yes |
| range_key_type | The type of the sort key (S, N, or B) | string | `S` | no |
| read_capacity | The read capacity of the dynamo db table | string | `5` | no |
| tags | Map of tags for the table | map | `<map>` | no |
| ttl_attribute_name | The attribute_name used for the TTL i.e. created_at | string | `` | no |
| ttl_enabled | Whether the ttl is enabled | string | `false` | no |
| write_capacity | The write capacity of the dynamo db table | string | `5` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn |  |
| id |  |

