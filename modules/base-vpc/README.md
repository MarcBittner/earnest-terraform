
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| account_id |  | string | - | yes |
| cidr_base |  | string | - | yes |
| external-allow-all-cidrs |  | string | `<list>` | no |
| fortknox_subnet_tags |  | map | `<map>` | no |
| is_leaf_hub |  | string | `false` | no |
| name |  | string | - | yes |
| number-to-letter-mapping |  | map | `<map>` | no |
| private_elb_subnet_tags |  | map | `<map>` | no |
| private_subnet_tags |  | map | `<map>` | no |
| private_tooling_subnet_tags |  | map | `<map>` | no |
| public_nat_subnet_tags |  | map | `<map>` | no |
| public_subnet_tags |  | map | `<map>` | no |
| region |  | string | `us-east-1` | no |
| region-az-count-mapping |  | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws_db_subnet_group.private_database.id |  |
| aws_elasticache_subnet_group.fortknox_elasticache.id |  |
| aws_elasticache_subnet_group.private_elasticache.id |  |
| aws_route_table.fortknox.id |  |
| aws_route_table.private.id |  |
| aws_route_table.private_elb.id |  |
| aws_route_table.private_tooling.id |  |
| aws_route_table.public.id |  |
| aws_route_table.public_nat.id |  |
| aws_security_group.allow_all.id | OUTPUTS |
| aws_security_group.allow_all_within_cloud.id | OUTPUTS |
| aws_security_group.allow_all_within_vpc.id | OUTPUTS |
| aws_security_group.qualys_sg.id |  |
| aws_security_group.ring_jumphost_sg.id |  |
| cidr |  |
| subnets.fortknox.availability_zones |  |
| subnets.fortknox.ids | outputs ############### |
| subnets.private.availability_zones |  |
| subnets.private.ids | outputs ############### |
| subnets.private_elb.availability_zones |  |
| subnets.private_elb.ids | outputs ############### |
| subnets.private_tooling.availability_zones |  |
| subnets.private_tooling.ids | outputs ############### |
| subnets.public.availability_zones |  |
| subnets.public.ids |  |
| subnets.public_nat.availability_zones |  |
| subnets.public_nat.ids |  |
| vpc.id | Outputs |

