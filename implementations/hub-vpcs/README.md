
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| environment-cidr-mapping |  | map | `<map>` | no |
| external-allow-all-cidrs |  | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| aws_route_table.fortknox.id |  |
| aws_route_table.private.ids |  |
| aws_route_table.public.id |  |
| aws_route_table.public_nat.id |  |
| aws_security_group.allow_all.id |  |
| aws_subnet.private.ids |  |
| aws_subnet.public.ids |  |
| aws_vpc.id |  |
| cidr |  |
| subnets.private.ids |  |
| subnets.public.ids |  |

